package main

import (
    "os"
    "log"
    "fmt"
    // "time"
    // "sync"
    "github.com/go-redis/redis"
    "net/http"
)


func newClient() *redis.Client  {
    host := os.Getenv( "REDIS_HOST" ) 
    pwd := os.Getenv( "REDIS_PASSWORD" ) 
    if host == "" {
        host = "127.0.0.1"
    }
    addr := fmt.Sprintf( "%s:6379", host  ) 
    log.Print( "connect to :", addr  )

    client := redis.NewClient(&redis.Options{
        Addr:    addr,
        Password: pwd, // no password set
        DB:       0,  // use default DB
        PoolSize: 64  ,
    })

    
    // if err != nil {
    //     log.Println( err)
    // } else {
    //     log.Println( pong )
    // }
    //
    return client 
}

func handler(w http.ResponseWriter, r *http.Request) {
    log.Println( r.URL , r.RequestURI , r.URL.Path  )
    fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
    
}

func main() {
    http.HandleFunc("/", handler)
    log.Fatal(http.ListenAndServe(":8080", nil))
}


