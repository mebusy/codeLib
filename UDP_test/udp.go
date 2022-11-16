package main

import (
	"log"
	"net"
    "flag"
    "fmt"
)

const RBUF_SIZE int = 64

var port = flag.Int("p", 1053, "udp port"  )
var help = flag.Bool("h", false, "help"  )

func main() {
    flag.Parse()
    if *help {
        flag.PrintDefaults()
        return
    }

    addr, _ := net.ResolveUDPAddr("udp",  fmt.Sprintf(":%d", *port)  )
    sock, err := net.ListenUDP("udp", addr)
	if err != nil {
		log.Fatal(err)
	}
	defer sock.Close()

    /*
    err = sock.SetReadBuffer( RBUF_SIZE )
    if err != nil {
        log.Println( err )
    }
    //*/

    log.Println( "udp listen on" , addr )

	for {
		buf := make([]byte, RBUF_SIZE)
		n, addr, err := sock.ReadFromUDP(buf)
		if err != nil {
			continue
		}
        log.Println( "read:" , n )
		go serve(sock, addr, buf[:n])
	}

}

func serve(conn *net.UDPConn, addr net.Addr, buf []byte) {
	// 0 - 1: ID
	// 2: QR(1): Opcode(4)
    prefix:=fmt.Sprintf( "server response to %s :", addr )
    log.Println( prefix )

	conn.WriteTo( append( []byte(prefix), buf... ), addr)
}

