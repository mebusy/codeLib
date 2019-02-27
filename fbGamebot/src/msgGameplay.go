package main

import (
    "bytes"
    // "crypto/tls"
    "encoding/json"
    "fmt"
    // "github.com/gorilla/mux"
    "io"
    "io/ioutil"
    "log"
    "net/http"
    // "net/url"
    // "os"
    // "strings"
    // "time"
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


func webhookHandlePOST(w http.ResponseWriter, r *http.Request) {
    // vars := mux.Vars(r)
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
    // Page-scoped ID of the bot user
    senderId := event.Sender.Id

    // FBInstant player ID
    // playerId := event.Game_play.Player_id

    // FBInstant context ID
    contextId := event.Game_play.Context_id

    payLoad := event.Game_play.Payload

    // log.Println( senderId, playerId , contextId  )

    sendMessage(senderId, contextId, "Message to game client", "Play now!", payLoad )
}

type sendMsgButton struct {
    Type    string `json:"type"`
    Title   string `json:"title"`
    Context string `json:"context,omitempty"`
    Payload string `json:"payload,omitempty"`
}
type sendMsgElement struct {
    Title   string          `json:"title"`
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

//
// Send bot message
//
// player (string) : Page-scoped ID of the message recipient
// context (string): FBInstant context ID. Opens the bot message in a specific context
// message (string): Message text
// cta (string): Button text
// payload (object): Custom data that will be sent to game session
//
func sendMessage(player, context, message, cta, payload string ) {
    var m sendMegData
    m.Recipient.Id = player
    m.Message.Attachment.Type = "template"
    m.Message.Attachment.Payload.Template_type = "generic"
    m.Message.Attachment.Payload.Elements = []sendMsgElement{
        {
            Title: message,
            Buttons: []sendMsgButton{
                {
                    Type:    "game_play",
                    Title:   cta,
                    Context: context,
                    Payload: payload,
                },
            },
        },
    }

    b, err := json.Marshal(m)
    if err != nil {
        log.Println("error:", err)
        return
    }
    // log.Println( string(b)  )
    _ = b
    go callSendAPI( b )
}

func callSendAPI(messageBytes []byte ) {
    // This transport is what's causing unclosed connections.
    // use proxy settting manually
    // Note: some version of go can not use https_proxy:  like 
    // https://127.0.0.1:3128, but works with http://127.0.0.1:3128
    /*
    tr := &http.Transport{
        TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
        Proxy: http.ProxyFromEnvironment ,
    }
    http_client := &http.Client{Timeout: 15 * time.Second, Transport: tr}
    _ = http_client 
    //*/

    //*
    graphApiUrl := "https://graph.facebook.com/me/messages?access_token=" + PAGE_ACCESS_TOKEN
    res, err := http.Post(graphApiUrl, "application/json", bytes.NewBuffer(messageBytes))
    if err != nil {
        log.Println(err)
        return
    }
    io.Copy(ioutil.Discard, res.Body)
    res.Body.Close()
    /*/
      res , err := http_client.Get( "https://www.baidu.com" )
      if err != nil {
          log.Println( err )
          return
      }
      body, _ := ioutil.ReadAll(res.Body)
      res.Body.Close()

      log.Println( body  )

      //*/
}
