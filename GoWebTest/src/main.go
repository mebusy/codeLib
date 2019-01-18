package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"net/http"
    "net/http/httputil"
    "tools"
    "log"
    "dbconn"
    "runtime"
    "fs"
    "os"
)

func testHandler(w http.ResponseWriter, r *http.Request) {
	// w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "test done")
}
func test2Handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "test2")
}



func MysqltestHandler(w http.ResponseWriter, r *http.Request) {
    dbconn.MysqlTest() 
	fmt.Fprintf(w, "mysql done")
}
func RedistestHandler(w http.ResponseWriter, r *http.Request) {
    dbconn.RedisTest() 
	fmt.Fprintf(w, "redis done")
}

func WcGameHandler(w http.ResponseWriter, r *http.Request) {
    vars := mux.Vars(r)
    // w.WriteHeader(http.StatusOK)
    fmt.Fprintf(w, "%v", vars )
}

// type MiddlewareFunc func(http.Handler) http.Handler
func loggingMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        // Do stuff here
        data , _ := httputil.DumpRequest( r, false )
        // log.Println(r.RequestURI)
        log.Println( string(data)  )

        // Call the next handler, which can be another middleware in the chain, or the final handler.
        next.ServeHTTP(w, r)
    })
}



func main() {   
    runtime.GOMAXPROCS(1)
    tools.DumpGoroutines()
    defer dbconn.MysqlClose()
    defer dbconn.RedisClose()

    pwd, err := os.Getwd()
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }

    fs.StartNewWatcher( pwd  ) 

	r := mux.NewRouter()
    // Routes are tested in the order they were added to the router. If two routes match, the first one wins:
    r.HandleFunc("/{game}/{env}/v{version:\\d+}/{uid:[0-9a-zA-Z-]+}", WcGameHandler)

	r.HandleFunc("/test", testHandler)
	r.HandleFunc("/mysqltest", MysqltestHandler)
	r.HandleFunc("/redistest", RedistestHandler)

    r.HandleFunc( "/test2", test2Handler ).Host("localhost:8001").Methods("GET") // .Schemes("http")

    // r.PathPrefix("/").Handler(catchAllHandler)
    r.Use(loggingMiddleware)

    // s := r.PathPrefix("/products").Subrouter()
	http.Handle("/", r)

    listenOn := ":8001" 
    log.Println( "test IP:" , tools.GetIP() , "will use CPU:", runtime.GOMAXPROCS(0),"listen on ", listenOn )

	log.Fatal( http.ListenAndServe( listenOn , nil) )
}



