package main

import (
	"dbconn"
	"fmt"
	"github.com/facebookgo/pidfile"
	"github.com/gorilla/mux"
	"log"
	"net"
	"net/http"
	"net/http/httputil"
	"os"
	"runtime"
	"time"
	"tools"
)

func testHandler(w http.ResponseWriter, r *http.Request) {
	// w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "test done v1.2")
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
	fmt.Fprintf(w, "%v", vars)
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

	tools.DumpGoroutines()
	defer dbconn.MysqlClose()
	defer dbconn.RedisClose()

    // Enable line numbers in logging
    log.SetFlags(log.LstdFlags | log.Lshortfile)

	/*
	   pwd, err := os.Getwd()
	   if err != nil {
	       fmt.Println(err)
	       os.Exit(1)
	   }
	   //*/

	r := mux.NewRouter()
	// Routes are tested in the order they were added to the router. If two routes match, the first one wins:
	r.HandleFunc("/{game}/{env}/v{version:\\d+}/{uid:[0-9a-zA-Z-]+}", WcGameHandler)

	r.HandleFunc("/test", testHandler)
	r.HandleFunc("/mysqltest", MysqltestHandler)
	r.HandleFunc("/redistest", RedistestHandler)

	r.HandleFunc("/test2", test2Handler).Host("localhost:8001").Methods("GET") // .Schemes("http")

	// r.HandleFunc("/", catchAllHandler)
	r.Use(loggingMiddleware)

	// s := r.PathPrefix("/products").Subrouter()

	listenOn := ":8001"
	log.Println("test IP:", tools.GetIP(), "will use CPU:", runtime.GOMAXPROCS(0), "listen on ", listenOn)

	// http.ListenAndServe( ":8001" , r )
	// following code is try to add the hotupdate feature
	// or use GIN for hotupdate feature
	// gin  -a 8001  run  main.go   , and request to  localhost:3000

	http.Handle("/", r)

	srv := &http.Server{
		Addr: listenOn,
		// Good practice to set timeouts to avoid Slowloris attacks.
		WriteTimeout: time.Second * 15,
		ReadTimeout:  time.Second * 15,
		IdleTimeout:  time.Second * 60,
		Handler:      r, // Pass our instance of gorilla/mux in.
	}

	var listener net.Listener
	var err error
	if tools.LanuchForHotUpdate() {
		log.Println("Listening to existing file descriptor 3.")
		// cmd.ExtraFiles: If non-nil, entry i becomes file descriptor 3+i.
		// when we put socket FD at the first entry, it will always be 3(0+3)
		f := os.NewFile(3, "")
		listener, err = net.FileListener(f)
	} else {
		listener, err = net.Listen("tcp", srv.Addr)
	}

	if err != nil {
		log.Fatalf("listener error: %v", err)
	}

	if false {
		pidfile.SetPidfilePath("./pid")
		pidfile.Write()
		tools.EnableHostUpdate(srv, listener)
	}

	type tcpKeepAliveListener struct {
		*net.TCPListener
	}
	if err := srv.Serve(tcpKeepAliveListener{listener.(*net.TCPListener)}); err != nil {
		log.Fatal(err)
	}
}
