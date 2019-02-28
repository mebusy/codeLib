package dbconn

import (
    "log"
    "time"
)

func StartWorker() {
    // go func() {
    //     for {
    //             
    //     }    
    // }    
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
    }
    // log.Println( "UpdatePlayerInfo:" , val  )
    client.Expire( key , 7*24*3600*time.Second)

    log.Println( getMillis()  )
}
