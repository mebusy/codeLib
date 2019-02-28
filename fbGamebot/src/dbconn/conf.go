package dbconn

import (
    "os"
    // "log"
)

var redis_host  string 
var redis_password  string 

func init() {

    redis_host = os.Getenv( "REDIS_HOST" )
    redis_password = os.Getenv( "REDIS_PASSWORD" )

    if redis_host == "" {
        redis_host = "127.0.0.1"    
    }
    
    _ = redis_password
}


