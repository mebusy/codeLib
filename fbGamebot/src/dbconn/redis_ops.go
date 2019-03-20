package dbconn

import (
    "github.com/go-redis/redis"
    "log"
    "time"
    "event"
    "fmt"
    "math/rand"
    "strconv"
)


var KEY_SCHEDULE_EVENTS = "zScheduledEvents"
var LUA_POPTASK = `
local entries = redis.call("zrangebyscore",KEYS[1],ARGV[1],ARGV[2]);
local t_res = {}
if table.getn(entries) > 0 then
    local eventKey = entries[1]
    redis.call("zrem",KEYS[1],eventKey);
    local idx = string.find( eventKey , "|" )
    if idx == nil then
        t_res["err"] = "event id didn't containt '|'"
        return cjson.encode( t_res )
    end 

    local playerId =  string.sub( eventKey ,1, idx-1 ) 
    
    local botId = redis.call( "hget" , playerId  , "botId" )
    if not botId  then
        t_res["err"] = "can not fetch bot id"
        return cjson.encode( t_res )
    end

    while true do
        local key_msg = playerId .. "_msg" 
        local tasks = redis.call( "zrange" , key_msg , 0, 0  )
        if (not tasks) or #tasks == 0 then
            t_res["err"] = "_msg array is empty"
            return cjson.encode( t_res )
        end
        local task = tasks[1]
        redis.call("ZINCRBY", key_msg , 100 ,  task  )
        
        local idx = string.find( task , "|" )
        if idx == nil then
            t_res["data"] = botId .. "|" .. task
            return cjson.encode( t_res )
        end 

        local event_name = string.sub( task ,1, idx-1 ) 
        local friendId = string.sub( task , idx+1  )
        local nickname = redis.call( "hget" , friendId   , "nickname" ) 
        if not nickname then
            -- nickname can not fetch , do next meg 
        else 
            t_res["data"] = botId .. "|" .. event_name   .. "|"  ..  (nickname or friendId  )  .. "|"  ..  friendId 
            return cjson.encode( t_res )
        end 

    end 
else
    t_res["err"] = "EVENT_UNAVAILABLE"
    return cjson.encode( t_res )
end
`

var SHA_LUA_POPTASK = ""
func PopTask( isMsgTest  bool ) string {
    client := getRedis()
    var err error
    var val interface{}
    
    if SHA_LUA_POPTASK == "" {
        var sha1 string
        sha1 , err = client.ScriptLoad(  LUA_POPTASK).Result()
        if err != nil {
            log.Println( err )     
            return ""
        }
        log.Println( "script load:" ,  sha1 ) 

        SHA_LUA_POPTASK = sha1 
    }

    if isMsgTest {
        // for test 
        val , err =  client.EvalSha( SHA_LUA_POPTASK , []string{KEY_SCHEDULE_EVENTS} ,  0,  "+inf"  , 1  ).Result()
    } else {
        val , err =  client.EvalSha( SHA_LUA_POPTASK , []string{KEY_SCHEDULE_EVENTS} ,  0, getMillis() , 1  ).Result()
    }

    if err != nil {
        log.Println(err) 
        // if error happen , try reload script
        SHA_LUA_POPTASK = "" 
        return ""
    }
    
    return val.(string)
}


func getMillis() int64 {
    now := time.Now()
    nanos := now.UnixNano()
    millis := nanos / 1000000
    return millis 
}

func UpdatePlayerInfo( playerId string , fields map[string]interface{}  ) {
    client := getRedis()
    key := playerId  // fb id
    

    _ , err := client.HMSet( key , fields ).Result()
    if err != nil {
        log.Println( err )    
        // not return ,keep TTL
    }
    client.Expire( key , 7*24*3600*time.Second)
}

func UpdateAvailableMessage( playerId string , firstRun bool , challengedFriendId, randomFriendId, top1player string , testMsgId int ) {
    client := getRedis()
    key := playerId + "_msg" // fb id
    
    client.Del( key )
    params := []redis.Z {}

    for k,v := range event.Conf {
        conf := event.Conf[k]
        prio := conf.Priority 
        if testMsgId > 0 && testMsgId == prio {
            prio -= 10     
        }
        isTestingMsg := prio < 0

        if v.Condition == 0 || ( k == "THANK" && firstRun  ) {
            params = append( params , redis.Z{ float64(prio) , k } )
        } else {
            combo_key := "" 
            if k == "VS" && ( challengedFriendId != "" || isTestingMsg )  {
                combo_key = fmt.Sprintf( "%s|%s" , k,  playerId )    
                if ! isTestingMsg {
                    // prod flow
                    key_msg := challengedFriendId +  "_msg"
                    ttl,err := client.TTL( key_msg ).Result() 
                    if err != nil {
                        log.Println( err )    
                    } else if ttl > 5  {
                        // you can update the priority of other players event
                        client.ZAddNX(  key_msg , redis.Z {float64(prio) , combo_key}  )    
                    }
                    continue 
                }
            }
            if  k == "toVS" && randomFriendId != "" {
                combo_key = fmt.Sprintf( "%s|%s" , k,  randomFriendId )    
            }
            if k == "HIGHSCORE" && top1player != "" && top1player != playerId  {
                combo_key = fmt.Sprintf( "%s|%s" , k,  top1player )    
            }

            if combo_key != "" {
                params = append( params , redis.Z{ float64(prio) , combo_key } )
            }
        }
    }

    client.ZAdd( key, params... )
    
    client.Expire( key , 7*24*3600*time.Second)

}


var DAY_MILLIS int64 = 24*3600*1000
var EventDays = []int64{ 1,2,3, 7,10 }  // today, next day , 
func ScheduleEvent( playerId string , timezone int64 , firstRun bool, testMsgId int  )  {
    /*
    client := getRedis()
    v , err := client.TTL( playerId ).Result() 
    if err != nil {
        log.Println( err ) 
        return  
    }
    if v <= 0 {
        log.Println( playerId , " has expired" )
        return     
    }
    //*/

    client := getRedis()
    millis := getMillis()  
    params := []redis.Z {}
    
    var time_local_h  int64 = ((millis%DAY_MILLIS)/(3600*1000) + timezone + 24) % 24 
    // log.Println( "current hour:  " , time_local_h  )
    for i , d := range EventDays {
        if i == 0 {
            // next 2 hour
            // 8:00 - 22:00 , push 
            if time_local_h  + 2 > 8 && time_local_h  + 2 < 22 {
                params = append( params ,redis.Z{ float64( millis + 3600*1000 * 2 ) , fmt.Sprintf( "%s|%d" , playerId , i  )  } )
            }
            continue     
        }
        var h int64 = 16
        randomTick := rand.Int63n(  3600*1000 * 3 )
        params = append( params ,redis.Z{ float64( millis - (millis%DAY_MILLIS) + 3600*1000 * ( (d-1)*24 + h - timezone  ) + randomTick ) , fmt.Sprintf( "%s|%d" , playerId , i  )  } )
    }

    if firstRun {
        params = append( params ,redis.Z{ float64(millis)   , fmt.Sprintf( "%s|%d" , playerId , 99  )  } )    
    }

    if testMsgId > 0 {
        params = append( params ,redis.Z{ float64(millis)   , fmt.Sprintf( "%s|%d" , playerId , 100  )  } )    
    }
    // log.Printf( "%+v \n" , params  )
    client.ZAdd( KEY_SCHEDULE_EVENTS, params... )
}



func GetMaxConnection() int {
    client := getRedis()

    vals , err := client.ConfigGet( "maxclients" ).Result()
    if err != nil {
        log.Println( err )
    }
    if len(vals) == 2 {
        i, err := strconv.Atoi( vals[1].(string)  )
        if err != nil {
            // handle error
            log.Println( err )
        } else {
            return i 
        }
    }

    return 0
}

func GetRedisInfo() string {
    client := getRedis()
    info , err := client.Info(  ).Result() 
    if err != nil {
        log.Println( err  )    
    }
    return info
}
