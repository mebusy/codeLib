package main

import (
    "github.com/gorilla/mux"
    "runtime"
    // "dbconn" 
    "net/http"
    "net/http/httputil"
    "fmt"
    "log"
)

func webhookHandle  (w http.ResponseWriter, r *http.Request) {
    vars := mux.Vars(r)
    // w.WriteHeader(http.StatusOK)
    fmt.Fprintf(w, "%v", vars)
}
func catchAllHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "catch all")     
}

// type MiddlewareFunc func(http.Handler) http.Handler
func loggingMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        // Do stuff here
        data, _ := httputil.DumpRequest(r, false)
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
    r.HandleFunc("/{game}", webhookHandle)
    r.Use(loggingMiddleware)

    r.HandleFunc( "/" , catchAllHandler  )


    log.Println( "server start" )
    http.ListenAndServe( ":5757" , r ) 

}
