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
)

func testHandler(w http.ResponseWriter, r *http.Request) {
	// w.WriteHeader(http.StatusOK)
    data , err := httputil.DumpRequest( r, true )
    if err == nil {
        log.Println( "Request:" , string(data) )    
    }
	fmt.Fprintf(w, "test done")
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


func main() {   
    runtime.GOMAXPROCS(1)
    log.Println( "test IP:" , tools.GetIP() , "will use CPU:", runtime.GOMAXPROCS(0) )
    tools.DumpGoroutines()
    defer dbconn.MysqlClose()
    defer dbconn.RedisClose()

	r := mux.NewRouter()
	r.HandleFunc("/test", testHandler)
	r.HandleFunc("/mysqltest", MysqltestHandler)
	r.HandleFunc("/redistest", RedistestHandler)
    r.HandleFunc("/{game}/{env}/v{version:\\d+}/{uid:[0-9a-zA-Z-]+}", WcGameHandler)
	http.Handle("/", r)
	http.ListenAndServe(":8080", nil)
}



