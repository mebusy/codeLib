package main

import (
    "flag"
    "log"
    "net/http"
    "fmt"
    "github.com/gorilla/websocket"
)

var port = flag.String("port", "5001", "http service port")

var upgrader = websocket.Upgrader{} // use default options

func echo(w http.ResponseWriter, r *http.Request) {
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
        log.Printf("recv: %s", message)
        err = c.WriteMessage(mt, message)
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
    http.HandleFunc("/echo", echo)
    http.HandleFunc("/", handle)
    log.Fatal(http.ListenAndServe( fmt.Sprintf( "0.0.0.0:%s" , *port ) , nil))
}

