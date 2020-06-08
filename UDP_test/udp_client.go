package main

import (
  "net"
  "log"
)


func main() {
    addr, _ := net.ResolveUDPAddr("udp", "127.0.0.1:1053")
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


}
