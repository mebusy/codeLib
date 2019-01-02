package main 

import (
    "github.com/graarh/golang-socketio"
    "github.com/graarh/golang-socketio/transport"
    "log"
    "time"
    "fmt"
    "sync"
    "github.com/bitly/go-simplejson"
    "flag"
)

type Message struct {
    Data string
}

var _m_activeUser sync.Map 
var ChanAU = make(chan int, 1 )
func SetActiveUser(  key int ) { 
    ChanAU <- 1
   _m_activeUser.Store( key , 1 ) 
   <- ChanAU 
}

func Summary() {
    for {
        time.Sleep( time.Second * 10 )     

        ChanAU <- 1
        cnt := 0 
        _m_activeUser.Range(func(key interface{}, value interface{}) bool {
            cnt += 1
            _m_activeUser.Delete(key)
            return true
        })
        
        <- ChanAU 
        log.Println( "total active user:" , cnt  )
    }
}



var m sync.Map 

type func_next func( cmd string, res string  ) 

func sendJoin(cmd string , args interface{}  ,  c *gosocketio.Client  , next func_next ) string {
    result, err := c.Ack( cmd, args , time.Second* 30 )
    if err != nil {
        // log.Println("send" , cmd,  err)
    } else {
        // log.Printf("result to %s:%s \n", cmd,  result)
        if next != nil {
            next( cmd , result  )    
        }
    }

    return result 
}

type User struct {
    Id int  
    St string
    Ended bool
}

func NewUser( id int ) *User  {
    return &User {
        Id : id ,     
        St : "st_init" , 
        Ended : false }
}

// var HOST = "localhost" 
// var PORT = 5757

var HOST = flag.String( "host" ,  "localhost", "" )
var PORT = flag.Int( "port" ,  5757, "" )
func (u *User) Start() {
    c, err := gosocketio.Dial(
    gosocketio.GetUrl( *HOST, *PORT, *PORT==443 ),
    transport.GetDefaultWebsocketTransport())
    if err != nil {
        log.Println("dial", err)
        time.Sleep( time.Second * 1 )
        go u.Start()
        return 
    }

    err = c.On(gosocketio.OnConnection, func(h *gosocketio.Channel) {
        log.Println( u.Id, "Connected")
        <- Chan
    })
    if err != nil {
        log.Println( "OnConnection", err)
    }

    err = c.On(gosocketio.OnDisconnection, func(h *gosocketio.Channel) {
        log.Println(u.Id, "Disconnect")
        u.Ended = true 
        // c.Close()

    })
    if err != nil {
        log.Println("OnDisconnection", err)
    }


    err = c.On("log", func(h *gosocketio.Channel, args Message) {
        u.St = "st_connected"
        u.Update(c)
    })
    if err != nil {
        log.Println("onLog", err)
    }


    err = c.On("gameToStart", func(h *gosocketio.Channel, args Message) {
        // log.Println( "gameToStart" )
        u.St = "st_started"
    })
    if err != nil {
        log.Println("onGameStart",err)
    }



}

func (u *User) Update( c *gosocketio.Client ) {
    for {
        if u.Ended {
            break
        }

        switch u.St {
        case "st_connected":
            d := map[string]string{ "openid" : fmt.Sprintf( "id_%d" , u.Id ) ,
                                           "uid" : fmt.Sprintf( "id_%d" , u.Id ) ,
                                          "name" : fmt.Sprintf( "name_%d" , u.Id ) ,
                                     "avatarUrl" : fmt.Sprintf( "avatarUrl_%d" , u.Id ) }
            sendJoin( "login" , d ,   c ,
                func( cmd string ,res string ) {
                    // log.Printf( "%d cmd:%s, result:%s\n" , u.Id, cmd, res  ) 
                    js, _ := simplejson.NewJson([]byte(res))
                    code , _ := js.Get("code").Int()
                    if code == 200 {
                        u.St = "st_logined"
                    }

                })
        case "st_logined":
            v,_ := m.Load( u.Id/10 )
            // log.Println( v,b )
            // room owner create room
            if u.Id % 10 == 0 {
                if v == nil {
                    u.St = "st_tocreateroom"
                } else {
                    u.St = "st_toenterroom"
                }
            } else {
                if v == nil {
                    u.St = "st_waitroomcreate" 
                } else {
                    u.St = "st_toenterroom"
                }
            }
        case "st_tocreateroom":
            u.CreateRoom( c  )
        case "st_waitroomcreate" :
            v,_ := m.Load( u.Id/10 )

            if v == nil {
                continue
            }
            u.St = "st_toenterroom"
        case "st_toenterroom":
            u.EnterRoom( c )
        case "st_entered":
            //*
            if u.Id % 10 == 0 {
                u.QueryRoom( c  )
            }
            /*/
            u.QueryRoom2( c  )
            //*/
        case "st_roomfull" :
            // only master will in 
            u.StartGame(c )
        case "st_started" :
            SetActiveUser( u.Id   )
            time.Sleep( time.Second * 4 )
            u.QueryRoom( c) 
        case "st_play":
            u.Play( c )
            
        } // end switch
        time.Sleep( time.Second * 1 )
    }

    time.Sleep( time.Second * 1 )
    log.Println(u.Id, "no reconnect")
    u.Ended = false 
    // go u.Start()
}
func (u *User) StartGame( c *gosocketio.Client  ) {

    rid,_ := m.Load( u.Id/10 )
    d_enter := map[string]interface{} {
        "id": rid.(string) ,
         "uid":fmt.Sprintf( "id_%d" , u.Id )}

    c.Emit( "start" , d_enter ) 
}
func (u *User) QueryRoom2( c *gosocketio.Client  ) {
    rid,_ := m.Load( u.Id/10 )

    d_enter := map[string]interface{} {
        "id": rid.(string) ,
         "uid":fmt.Sprintf( "id_%d" , u.Id )}

    time.Sleep( time.Second * 5  )
    sendJoin( "queryRoom" , d_enter , c ,  
        func( cmd string ,res string ) { 
            // log.Printf( "%d cmd:%s, result:%s\n" , u.Id, cmd, res  ) 
            SetActiveUser( u.Id  )
        })
}

func (u *User) QueryRoom( c *gosocketio.Client  ) {
    rid,_ := m.Load( u.Id/10 )

    d_enter := map[string]interface{} {
        "id": rid.(string) ,
         "uid":fmt.Sprintf( "id_%d" , u.Id )}

    sendJoin( "queryRoom" , d_enter , c ,  
        func( cmd string ,res string ) { 
            // log.Printf( "%d cmd:%s, result:%s\n" , u.Id, cmd, res  ) 
            js, _ := simplejson.NewJson([]byte(res))
            code , _ := js.Get("code").Int()
            if code == 200 {
                room_status ,_ := js.Get("data").Get("status").String() 
                if room_status == "waiting" {
                    // log.Println( "waiting" ) 
                    users , _ := js.Get( "data" ).Get("users").Array() 
                    nUser := len( users )
                    // log.Println( "total users:" , nUser )
                    if nUser == 10 {
                        u.St = "st_roomfull"
                    }
                } else if room_status == "playing" {
                    cur,_ := js.Get( "data" ).Get("current").String()
                    if cur == fmt.Sprintf( "id_%d" , u.Id ) {
                        u.St = "st_play"    
                    }
                }
            }
        })
}

func (u *User) CreateRoom( c *gosocketio.Client  ) {

    // create room
    d_create := map[string]interface{} {"user":fmt.Sprintf( "id_%d" , u.Id ),
              "capacity":10,
              "game":"minigame-dunkshot",
              "includeMaster":1,
              "uid":fmt.Sprintf( "id_%d" , u.Id )}
    sendJoin( "create" , d_create , c , 
        func( cmd string ,res string ) {
            // log.Printf( "%d cmd:%s, result:%s\n" , u.Id, cmd, res  ) 
            js, _ := simplejson.NewJson([]byte(res))
            code , _ := js.Get("code").Int()
            if code == 200 {
                room_id , _ := js.Get("data").Get("room_id").String()
                log.Println( u.Id, "create room: " , room_id )
                m.Store( u.Id/10, room_id )
                u.St = "st_entered"
            }

        })
}
func (u *User) EnterRoom( c *gosocketio.Client  ) {
    rid,_ := m.Load( u.Id/10 )

    d_enter := map[string]interface{} {
        "id": rid.(string) ,
         "uid":fmt.Sprintf( "id_%d" , u.Id )}
    sendJoin( "enter" , d_enter , c  , 
        func( cmd string ,res string ) { 
            // log.Printf( "%d cmd:%s, result:%s\n" , u.Id, cmd, res  ) 
            js, _ := simplejson.NewJson([]byte(res))
            code , _ := js.Get("code").Int()
            if code == 200 {
                u.St = "st_entered"
            }
        })
}

func (u *User) Play( c *gosocketio.Client  ) {

    d_play := map[string]interface{} {
        "flyTime":22,
        "score":1,
        "uid":fmt.Sprintf( "id_%d" , u.Id )}
    sendJoin( "done" , d_play , c  , 
        func( cmd string ,res string ) { 
           // log.Printf( "%d cmd:%s, result:%s\n" , u.Id, cmd, res  ) 
            js, _ := simplejson.NewJson([]byte(res))
            code , _ := js.Get("code").Int()
            if code == 200 {
                u.St = "st_started"
            }
        })
}
