package main

import (
    "github.com/gorilla/mux"
    "runtime"
    // "dbconn" 
    "net/http"
    "net/http/httputil"
    "fmt"
    "log"
    "strings"
    "os"
)

var mapEnvVars = map[string]string {}

const (
    KEY_GAME = "game"
)

func webhookHandleGET  (w http.ResponseWriter, r *http.Request) {
    vars := mux.Vars(r)
    game:= vars[ KEY_GAME ]

    envVarVerifyToken := "BOT_VERIFY_TOKEN_" + strings.ToUpper( game )
    v,ok := mapEnvVars[ envVarVerifyToken ]
    if !ok {
        v = os.Getenv( envVarVerifyToken )      
        if v == "" {
            http.Error( w, "unvalid game: " + game   , http.StatusForbidden )
            return 
        }
        mapEnvVars[ envVarVerifyToken ] = v 
    }

    // log.Println( r.URL.Query()  )
    hub_mode := r.FormValue(  "hub.mode" )
    hub_verify_token := r.FormValue( "hub.verify_token" )
    hub_challenge := r.FormValue( "hub.challenge" )

    if hub_mode ==  "subscribe"  && hub_verify_token == v  {
        log.Println("Validating webhook");
        fmt.Fprintf(w, hub_challenge )
    } else {
        http.Error( w, "Failed validation. Make sure the validation tokens match:" + game   , http.StatusForbidden  )
    }
    
    // fmt.Fprintf(w, "hub.mode: %v", hub_mode  )
}

func catchAllHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "catch all")     
}

// type MiddlewareFunc func(http.Handler) http.Handler
func loggingMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        // Do stuff here
        data, _ := httputil.DumpRequest(r, true )
        // log.Println(r.RequestURI)
        log.Println(string(data))

        // Call the next handler, which can be another middleware in the chain, or the final handler.
        next.ServeHTTP(w, r)
    })
}





func main() {
    runtime.GOMAXPROCS(1)
    // defer dbconn.RedisClose()

    r := mux.NewRouter()
    r.HandleFunc(fmt.Sprintf("/{%s}" , KEY_GAME  ), webhookHandleGET ).Methods("GET")
    r.HandleFunc(fmt.Sprintf("/{%s}" , KEY_GAME  ), webhookHandlePOST ).Methods("POST")
    r.Use(loggingMiddleware)

    r.HandleFunc( "/" , catchAllHandler  )


    log.Println( "server start" )
    http.ListenAndServe( ":5757" , r ) 

}
