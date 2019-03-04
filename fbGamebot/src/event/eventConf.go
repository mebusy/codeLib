package event

import (
    "log"
    "encoding/json"
    "io/ioutil"
)

type DEFINE struct {
    Button []string
    Entry []string 
    Priority int
    Message string 
    Condition int
}

var Conf = map[string] DEFINE {}
func LoadEvents() {
    b, err := ioutil.ReadFile( "event.txt" )
    if err != nil {
        log.Fatalln( err )
    }

    err = json.Unmarshal(b, &Conf )
    if err != nil {
        log.Fatalln( err )
    }

    /*
    for k,v := range Conf {
        if  v.Condition == 1 {
            continue
        }

        NonConditionEvent = append( NonConditionEvent , k  )
    }
    //*/

    // log.Println( "%+v" , NonRepeatScheduledEvent  )
}
