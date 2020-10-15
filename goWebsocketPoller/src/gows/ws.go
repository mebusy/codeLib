package gows

import (
    "sync"
    "github.com/gorilla/websocket"
	"net/http"
    "log"
)

var upgrader = websocket.Upgrader{
    ReadBufferSize:  512, // comments these 2 lines if you want use default upgrader
    // WriteBufferSize: 1024,
    WriteBufferPool: &sync.Pool{},
}


func WsHandle(w http.ResponseWriter, r *http.Request) {
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Print("upgrade err:", err)
		return
	}
	// defer conn.Close()
	if err := epoller.Add(conn); err != nil {
		log.Printf("Failed to add connection")
		conn.Close()
	}
    log.Printf( "connection %p connected", conn )

    /*
	for {
        messageType, p, err := conn.ReadMessage()
        if err != nil {
            log.Println(err)
            break
        }
        if err := conn.WriteMessage(messageType, p); err != nil {
            log.Println(err)
            break
        }
	}

    log.Printf( "connection %p disconnected", conn )
    //*/
}
