package main

import (
    "bytes"
    "dbconn"
    // "crypto/tls"
    "encoding/json"
    "fmt"
    // "github.com/gorilla/mux"
    // "io"
    "io/ioutil"
    "log"
    "net/http"
    // "net/url"
    // "os"
    "strings"
    "time"
    "event"
)

type gameplayMsg struct {
    Object string
    Entry  []entryMsg
}

type entryMsg struct {
    Id        string
    Messaging []eventMsg
    Time      int64
}

type eventMsg struct {
    Game_play struct {
        Game_id    string
        Player_id  string
        Context_id string
        // Context_type string 
        Payload    string 
    }
    Recipient struct {
        Id string
    }
    Sender struct {
        Id string
    }
    Timestamp int64
}

type sessionData struct {
    Timezone float64
    FirstRun bool 
    ChallengedFriend string 
    RandomFriendId string 
    Top1player string 
    Nickname string 
}

func webhookHandlePOST(w http.ResponseWriter, r *http.Request) {
    // vars := mux.Vars(r))
    // game := vars[KEY_GAME]

    b, err := ioutil.ReadAll(r.Body)
    defer r.Body.Close()
    if err != nil {
        log.Println(err)
        fmt.Fprintf(w, err.Error())
        return
    }
    // log.Println( string(b) )

    var data gameplayMsg
    if err := json.Unmarshal(b, &data); err != nil {
        log.Println(err, b )
        fmt.Fprintf(w, err.Error())
        return
    }

    if data.Object == "page" {
        for _, entry := range data.Entry {
            // log.Println( "~~~~ entry ID: " , k, entry.Id )

            // pageID = entry.Id
            // timeOfEvent = entry.Time
            for _, event := range entry.Messaging {
                // fmt.Printf( "%+pageToken \n",  event.Game_play )
                isGameplayMsg := event.Game_play.Game_id != ""
                if isGameplayMsg {
                    receivedGameplay(event)
                } else {
                    log.Printf("unknow message: %+pageToken \n", event)
                }
            }
        }
    }

    fmt.Fprintf(w, "gameplay post.")
}

func receivedGameplay(event eventMsg) {

    // log.Println( "1" )
    // Page-scoped ID of the bot user
    senderId := event.Sender.Id

    // FBInstant player ID
    playerId := event.Game_play.Player_id

    // FBInstant context ID
    contextId := event.Game_play.Context_id

    payload := event.Game_play.Payload
    if payload != "" {
        var m sessionData 
        if err := json.Unmarshal( []byte(payload) , &m); err != nil {
            log.Println( err , payload )
            return
        }
        timezone := m.Timezone
        firstRun := m.FirstRun 
        // log.Println( playerId, timezone , firstRun )

        // protect , only valid payload can be handled
        fields := map[string]interface{} {}
        fields[ "timezone" ] = timezone 
        fields[ "botId" ] = senderId   // page scope id
        fields[ "nickname" ] = m.Nickname 

        dbconn.UpdatePlayerInfo( playerId , fields  )
        dbconn.UpdateAvailableMessage( playerId, firstRun , m.ChallengedFriend , m.RandomFriendId , m.Top1player  )


        _ = contextId 
        dbconn.ScheduleEvent( playerId , int64(timezone)  )
    }
    

    // log.Println( "2" )
}

type sendMsgButton struct {
    Type    string `json:"type"`
    Title   string `json:"title"`
    Payload string `json:"payload,omitempty"`
}

type defaultAction struct {
    Type string `json:"type"`    
}
type sendMsgElement struct {
    Title   string          `json:"title"`
    Image_url string  `json:"image_url"`
    Default_action defaultAction  `json:"default_action"`
    Buttons []sendMsgButton `json:"buttons"`
}

type sendMegData struct {
    Recipient struct {
        Id string `json:"id"`
    } `json:"recipient"`
    Message struct {
        Attachment struct {
            Type    string `json:"type"`
            Payload struct {
                Template_type string           `json:"template_type"`
                Elements      []sendMsgElement `json:"elements"`
            } `json:"payload"`
        } `json:"attachment"`
    } `json:"message"`
}
/*
type sendButtonData struct {
    Recipient struct {
        Id string `json:"id"`
    } `json:"recipient"`
    Message struct {
        Attachment struct {
            Type    string `json:"type"`
            Payload struct {
                Template_type string           `json:"template_type"`
                Text string `json:"text"`
                Buttons      []sendMsgButton `json:"buttons"`
            } `json:"payload"`
        } `json:"attachment"`
    } `json:"message"`
}
//*/

//
// Send bot message
//
// player (string) : Page-scoped ID of the message recipient
// context (string): FBInstant context ID. Opens the bot message in a specific context
// message (string): Message text
// cta (string): Button text
// payload (object): Custom data that will be sent to game session
//
func sendMessage( msgType , player, nickname  string ) {
    // message, cta, payload string 
    eData, ok := event.Conf[ msgType ]
    if !ok {
        log.Println( "unavailabe msgType:" , msgType  )
        return
    }

    message := eData.Message
    if nickname != "" {
        message = strings.ReplaceAll( message , "[FRIEND_NAME]" , nickname  )
    }
    // log.Println( message , nickname  )
    buttons := []sendMsgButton{} 
    for i, v := range eData.Button {
        buttons = append( buttons , sendMsgButton { Type:"game_play", Title:v , Payload: fmt.Sprintf( `{"entry":%s}`, eData.Entry[i] )  } )
    }

    var m sendMegData 
    m.Recipient.Id = player
    m.Message.Attachment.Type = "template"
    m.Message.Attachment.Payload.Template_type = "generic"


    // testUrl := "https://scontent-hkg3-2.xx.fbcdn.net/v/t39.2081-0/53286035_774550962902370_2138755759058452480_n.jpg?_nc_cat=110&_nc_ht=scontent-hkg3-2.xx&oh=19b21e21607495659201cf0af9c6733f&oe=5CDF1C92"
    var ele sendMsgElement 
    ele.Title = message 
    ele.Buttons = buttons
    ele.Image_url = fmt.Sprintf( "%s%s.jpg" , CDN_IMAGE ,  msgType )
    // log.Println( ele.Image_url   )
    ele.Default_action = defaultAction{ Type: "game_play" }

    m.Message.Attachment.Payload.Elements = []sendMsgElement{ ele }
    // m.Message.Attachment.Payload.Text = message 
    // m.Message.Attachment.Payload.Buttons = buttons

    //*/

    b, err := json.Marshal(m)
    if err != nil {
        log.Println("error:", err)
        return
    }
    // log.Println( string(b)  )
    _ = b

    cc_sendapi <- 1
    go callSendAPI( b )
}

var cc_sendapi = make(chan int, 1024 )
func callSendAPI(messageBytes []byte ) {
    defer func() {
        <- cc_sendapi
    }()

    // This transport is what's causing unclosed connections.
    // use proxy settting manually
    // Note: some version of golang can not use https_proxy:  like 
    // https://127.0.0.1:3128, but works with http://127.0.0.1:3128
    /*
    tr := &http.Transport{
        TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
        Proxy: http.ProxyFromEnvironment ,
    }
    http_client := &http.Client{Timeout: 15 * time.Second, Transport: tr}
    _ = http_client 
    //*/

    graphApiUrl := "https://graph.facebook.com/me/messages?access_token=" + PAGE_ACCESS_TOKEN
    res, err := http.Post(graphApiUrl, "application/json", bytes.NewBuffer(messageBytes))
    if err != nil {
        log.Println(err)
    } else {
        /*
        io.Copy(ioutil.Discard, res.Body)
        /*/
        b, err := ioutil.ReadAll(res.Body)
        if err != nil {
            log.Println( err )    
        }
        log.Println( string(b) )
            
        //*/
        res.Body.Close()
    }
}


type TASK_RESP struct {
    Err string
    Data string     
}

func StartWorker() {
    log.Println( "StartWorker" )
    go func() {
        interval := 1
        for {
            _val := dbconn.PopTask( *bogMesTest == 1 ) 
            var m TASK_RESP
            if err := json.Unmarshal([]byte(_val), &m); err != nil {
                log.Println(err, _val )
                continue
            }

            err := m.Err 
            if err != "" {
                if err == "EVENT_UNAVAILABLE" {
                    time.Sleep( time.Duration(interval) * time.Second  )
                    interval += 1
                    if interval > 15 {
                        interval = 15     
                    }
                } else {
                    log.Println( err ) 
                }
                continue    
            }
            data := m.Data 
            if data == "" {
                log.Println( "task response data is empty " )
                continue    
            }
            
             
            // botid | type | [nikename]
            vals := strings.Split( data, "|" )
            if len(vals) < 2 {
                log.Println( "poped task is incorrect:" , data  )
                return     
            }
            botId := vals[0]
            msgType := vals[1]
            nikename := ""
            if len(vals) >= 3 {
                nikename = vals[2]  
            }
            // log.Println(  botId, msgType  )
            sendMessage( msgType, botId, nikename  )             
        }    
    }()
}
