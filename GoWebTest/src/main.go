package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"net/http"
    "net/http/httputil"
    "tools"
    "log"
    "dbconn"
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



func main() {   
    log.Println( "test IP:" , tools.GetIP()  )
    tools.DumpGoroutines()
    defer dbconn.Close()

	r := mux.NewRouter()
	r.HandleFunc("/test", testHandler)
	r.HandleFunc("/mysqltest", MysqltestHandler)
	http.Handle("/", r)
	http.ListenAndServe(":8080", nil)
}
