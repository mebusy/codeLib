package main

import (
	"io"
	"log"
	"net"
    "fmt"
    // "os"
    "sync"
    "flag"
)

var listenPort = flag.Int( "p" , 31280 , "listen port" ) 
var targetURL = flag.String( "t", "127.0.0.1:3128" ,   "host:port" ) 

var GIT_COMMIT string
func main() {
    flag.Parse()

    log.Printf( "listen on:%d, target:%s commit:%s \n" , *listenPort , *targetURL,  GIT_COMMIT )
	// Listen on TCP port 2000 on all available unicast and
	// anycast IP addresses of the local system.
	l, err := net.Listen("tcp", fmt.Sprintf( ":%d" , *listenPort )  )
	if err != nil {
		log.Fatal(err)
	}
	defer l.Close()
	for {
		// Wait for a connection.
		conn, err := l.Accept()
		if err != nil {
			log.Fatal(err)
		}
        // log.Printf( "new client, %+v" , conn )
		// Handle the connection in a new goroutine.
		// The loop then returns to accepting, so that
		// multiple connections may be served concurrently.
        client := conn 
        target, err := net.Dial("tcp", *targetURL )
        if err != nil {
            log.Fatal("could not connect to target", err)
        }

        var wg sync.WaitGroup 
        // client -> target
        wg.Add(1) 
        go func() { 
            io.Copy(target, client) 
            wg.Done()
            // log.Println( "c -> t done" , client , target) 
        }()
        
        // target -> client 
        wg.Add(1)
        go func() { 
            io.Copy(client, target) 
            wg.Done()
            // log.Println( "t -> c done", client, target ) 
        }()
        // Shut down the connection.
        go func() {
            wg.Wait()
            conn.Close()
            target.Close() 
            // log.Println( "close c & t" , client, target  )
        }()
	}
}
