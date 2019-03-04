package dbconn

import (
    "github.com/go-redis/redis"
    "log"
    "time"
    "event"
    "fmt"
)


var KEY_SCHEDULE_EVENTS = "zScheduledEvents"
var LUA_POPTASK = `
local entries = redis.call("zrangebyscore",KEYS[1],ARGV[1],ARGV[2]);
if table.getn(entries) > 0 then
    local eventKey = entries[1]
    redis.call("zrem",KEYS[1],eventKey);
    local idx = string.find( eventKey , "|" )
    if idx == nil then
        return ""
    end 
    
    local botId = redis.call( "hget" , string.sub( eventKey ,1, idx-1 )  , "botId" )
    if not botId  then
        return ""
    end
    return botId .. "|" .. eventKey
else
    return ""
end
`
func PopTask() string {
    client := getRedis()
    val , err :=  client.Eval( LUA_POPTASK , []string{KEY_SCHEDULE_EVENTS} ,  0, getMillis() , 1  ).Result()
    if err != nil {
        log.Println(err) 
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

func UpdateAvailableMessage( playerId string , firstRun bool , challengedFriendId, randomFriendId, top1player string ) {
    client := getRedis()
    key := playerId + "_msg" // fb id
    
    client.Del( key )
    params := []redis.Z {}

    for k,v := range event.Conf {
        if v.Condition == 0 || ( k == "THANK" && firstRun  ) {
            conf := event.Conf[k]
            params = append( params , redis.Z{ float64(conf.Priority) , k } )
        } else {
            combo_key := "" 
            if k == "VS" && challengedFriendId != "" {
                combo_key = fmt.Sprintf( "%s|%s" , k,  challengedFriendId)    
            }
            if  k == "toVS" && randomFriendId != "" {
                combo_key = fmt.Sprintf( "%s|%s" , k,  randomFriendId )    
            }
            if k == "HIGHSCORE" && top1player != "" && top1player != playerId  {
                combo_key = fmt.Sprintf( "%s|%s" , k,  top1player )    
            }

            if combo_key != "" {
                conf := event.Conf[k]
                params = append( params , redis.Z{ float64(conf.Priority) , combo_key } )
            }
        }
    }

    client.ZAdd( key, params... )
    
    client.Expire( key , 7*24*3600*time.Second)

    if challengedFriendId != "" {
        // need cancel     
    }
}


var DAY_MILLIS int64 = 24*3600*1000
var EventDays = []int64{ 1,2,3, 5,7 }  // today, next day , ...
func ScheduleEvent( playerId string , timezone int64 )  {
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
    for i , d := range EventDays {
        var h int64 = 18
        params = append( params ,redis.Z{ float64( millis - (millis%DAY_MILLIS) + 3600*1000 * ( d*24 + h - timezone  ) ) , fmt.Sprintf( "%s|%d" , playerId , i  )  } )
    }
    // log.Printf( "%+v \n" , params  )
    client.ZAdd( KEY_SCHEDULE_EVENTS, params... )
}
