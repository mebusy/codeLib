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
        // even err, not return ,but keep  update TTL 
    }
    // log.Println( "UpdatePlayerInfo:" , val  )
    client.Expire( key , 7*24*3600*time.Second)

    // log.Println( getMillis()  )
}

var DAY_MILLIS int64 = 24*3600*1000
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
    for _ , k := range event.NonRepeatScheduledEvent {
        for i , h := range event.Conf[k].Hour {
            d :=  event.Conf[k].Day[i] 
            // add to current timestamp 
            if d == -1 {
                params = append( params ,redis.Z{ float64( millis + 3600*1000 * h ) , fmt.Sprintf( "%s|%s|%d" , playerId , k,i ) } )
            } else {
                params = append( params ,redis.Z{ float64( millis - (millis%DAY_MILLIS) + 3600*1000 * ( d*24 + h ) ) , fmt.Sprintf( "%s|%s|%d" , playerId , k,i ) } )
            }
            // log.Println( k, t )     
            
        } 
    }
    // log.Printf( "%+v \n" , params  )
    client.ZAdd( KEY_SCHEDULE_EVENTS, params... )
}
