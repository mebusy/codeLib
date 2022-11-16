package main

import (
  "net"
  "log"
  "flag"
  "fmt"
)

var port = flag.Int("p", 1053, "udp port"  )
var host = flag.String("host", "localhost", "host"  )
var help = flag.Bool("h", false, "help"  )

func main() {
    flag.Parse()
    if *help {
        flag.PrintDefaults()
        return
    }

    addr, _ := net.ResolveUDPAddr("udp", fmt.Sprintf( "%s:%d" , *host, *port  ))
    conn, err := net.DialUDP("udp", nil, addr )
    if err != nil {
        log.Fatal( err )
    }

    buf := make([]byte, 1700 )
    for i := 0 ; i< len(buf) ; i++ {
        buf[i] = byte( 65+ (i%26) )
    }
    buf[10] = 0
    buf[12] = 20

    n , err := conn.Write( buf )
    if err != nil {
        log.Println( err )
    } else {
        log.Println( "written: " , n  )
    }
    
    for i := 0 ; i< len(buf) ; i++ {
        buf[i] = 0
    }

    n , err = conn.Read( buf )
    if err != nil {
        log.Println(err)
    } else {
        log.Printf( "written: %q" , buf[:10]  )
    }


}
