package main

import (
    "sync"
    "flag"
    "time"
)
var totalUser = flag.Int( "n" , 100, "total user" )
var startIndex  = flag.Int( "s" , 0, "user start index" )
var wg sync.WaitGroup 
var Chan = make(chan int, 10 )
func main() {
    flag.Parse()

    wg.Add(1)

    go Summary() 

    for i := *startIndex ; i < *startIndex +  *totalUser ; i++ {
        if i%10 != 0 {
            continue    
        }
        Chan <- 1 
        u:= NewUser(  i  )
        go u.Start()
        time.Sleep( time.Second * 1 )
    }

    for i := *startIndex ; i < *startIndex +  *totalUser ; i++ {
        if i%10 == 0 {
            continue    
        }

        Chan <- 1 
        u:= NewUser(  i  )
        go u.Start()
        time.Sleep( time.Millisecond * 5 )
    }
    

    wg.Wait()
}
