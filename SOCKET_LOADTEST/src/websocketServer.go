package main

import (
    "flag"
    "log"
    "net/http"
    "fmt"
    "github.com/gorilla/websocket"
    "net"
)

var port = flag.String("port", "5001", "http service port")

var upgrader = websocket.Upgrader{} // use default options

var localIP = "" 

func GetIntranetIp() string {
    addrs, err := net.InterfaceAddrs()

    if err != nil {
        log.Fatal(err)
    }

    for _, address := range addrs {

        if ipnet, ok := address.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
            if ipnet.IP.To4() != nil {
                // fmt.Println("ip:", ipnet.IP.String())
                return ipnet.IP.String()
            }

        }
    }
    return ""
}

func echo(w http.ResponseWriter, r *http.Request) {
    log.Println( "echo route" )
    c, err := upgrader.Upgrade(w, r, nil)
    if err != nil {
        log.Print("upgrade:", err)
        return
    }
    defer c.Close()
    for {
        mt, message, err := c.ReadMessage()
        if err != nil {
            log.Println("read:", err)
            break
        }
        ret := fmt.Sprintf( "svc recv: %s , ip: %s", message, localIP)
        log.Println( ret )
        err = c.WriteMessage( mt, ([]byte)(ret) )
        if err != nil {
            log.Println("write:", err)
            break
        }
    }
}

func handle(w http.ResponseWriter, r *http.Request) {
   // w.Write(  byte[](fmt.Sprintf("Req: %s %s", r.URL.Host, r.URL.Path) ) )  
   fmt.Fprintf( w , "Req: %s %s", r.URL.Host, r.URL.Path )
}


func main() {
    flag.Parse()
    log.SetFlags(0)
    localIP = GetIntranetIp() 
    http.HandleFunc("/wss", echo)
    http.HandleFunc("/", handle)
    log.Fatal(http.ListenAndServe( fmt.Sprintf( "0.0.0.0:%s" , *port ) , nil))
}

