package event

import (
    "log"
    "encoding/json"
    "io/ioutil"
)

type DEFINE struct {
    Repeat int
    Button []string
    Hour []int64
    Day []int64
    Entry []string 
    Priority int
    Message string 
}

var Conf = map[string] DEFINE {}
var NonRepeatScheduledEvent = []string {}
func LoadEvents() {
    b, err := ioutil.ReadFile( "event.txt" )
    if err != nil {
        log.Fatalln( err )
    }

    err = json.Unmarshal(b, &Conf )
    if err != nil {
        log.Fatalln( err )
    }

    for k,v := range Conf {
        if k == "THANK" {
            continue
        }
        if v.Repeat > 0  {
            continue
        }

        NonRepeatScheduledEvent = append( NonRepeatScheduledEvent , k  )
    }

    // log.Println( "%+v" , NonRepeatScheduledEvent  )
}
