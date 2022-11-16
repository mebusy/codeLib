package gows

import (
    "log"
)

var epoller *epoll

func StartPoller() {
	var err error
	epoller, err = MkEpoll()
	if err != nil {
		panic(err)
	}

    go func() {
        for {
            connections, err := epoller.Wait()
            if err != nil {
                log.Printf("Failed to epoll wait %v", err)
                continue
            }
            for _, conn := range connections {
                if conn == nil {
                    continue
                }
                messageType, msg, err := conn.ReadMessage()
                if err != nil {
                    if err := epoller.Remove(conn); err != nil {
                        log.Printf("Maybe FATAL: Failed to remove %v", err)
                    }
                    conn.Close()
                    log.Printf( "connection %p disconnected", conn )
                    continue
                }

                if err := conn.WriteMessage(messageType, msg ); err != nil {
                    if err := epoller.Remove(conn); err != nil {
                        log.Printf("Maybe FATAL: Failed to remove %v", err)
                    }
                    conn.Close()
                    log.Printf( "connection %p disconnected", conn )
                    continue
                }
            } // end for connections
        } // end for {} 
    }()  // enf go func
}


