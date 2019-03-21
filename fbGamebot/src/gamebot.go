package main

import (
	"github.com/gorilla/mux"
	"runtime"
	"dbconn"
	"flag"
	"fmt"
	"log"
	"net/http"
	"net/http/httputil"
	"os"
	"strings"
    "event"
    _ "net/http/pprof"
    "net/url"
	"syscall"
)

var BOT_VERIFY_TOKEN string 
var PAGE_ACCESS_TOKEN string 
var CDN_IMAGE string

var proxyURL *url.URL  = nil 

func init() {
    BOT_VERIFY_TOKEN = os.Getenv( "BOT_VERIFY_TOKEN" )
    PAGE_ACCESS_TOKEN = os.Getenv( "PAGE_ACCESS_TOKEN" )
    if BOT_VERIFY_TOKEN == "" || PAGE_ACCESS_TOKEN == "" {
        log.Fatalln( "you must set env variable: `BOT_VERIFY_TOKEN` and `PAGE_ACCESS_TOKEN` " ) 
    }
    CDN_IMAGE = os.Getenv( "CDN_IMAGE" )
    if CDN_IMAGE == "" {
        log.Fatalln( "CDN_IMAGE is empty" )    
    }
    if ! strings.HasSuffix( CDN_IMAGE ,  "/" ) {
        CDN_IMAGE = CDN_IMAGE + "/"    
    }

    http_proxy := os.Getenv( "HTTP_PROXY" )
    if http_proxy != "" {
        p  , err := url.Parse( http_proxy )      
        if err != nil {
            log.Println( err )    
        } else {
            proxyURL = p 
            log.Println( "proxyURL ", proxyURL  )    
        }
    }
}

func webhookHandleGET(w http.ResponseWriter, r *http.Request) {
	// vars := mux.Vars(r)
	// game := vars[KEY_GAME]

	// log.Println( r.URL.Query()  )
	hub_mode := r.FormValue("hub.mode")
	hub_verify_token := r.FormValue("hub.verify_token")
	hub_challenge := r.FormValue("hub.challenge")

	if hub_mode == "subscribe" && hub_verify_token == BOT_VERIFY_TOKEN  {
		log.Println("Validating webhook")
		fmt.Fprintf(w, hub_challenge)
	} else {
		http.Error(w, "Failed validation. Make sure the validation tokens match:" , http.StatusForbidden)
	}

	// fmt.Fprintf(w, "hub.mode: %v", hub_mode  )
}

func catchAllHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "catch all")
}
func infoHandle(w http.ResponseWriter, r *http.Request) {
    s := fmt.Sprintf( "git commit: %s",  GitCommit   )
	fmt.Fprintf(w, "%s\n",  s  )


	var rLimit syscall.Rlimit
	err := syscall.Getrlimit(syscall.RLIMIT_NOFILE, &rLimit)
	if err != nil {
		log.Println("Error Getting Rlimit ", err)
	} else {
        fmt.Fprintf( w, "rlimt cur:%d , max: %d \n" , rLimit.Cur , rLimit.Max   )
    }

    info := dbconn.GetRedisInfo()
	fmt.Fprintf(w, "redis info:  %s \n", info  )
}

// type MiddlewareFunc func(http.Handler) http.Handler
func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Do stuff here
		data, _ := httputil.DumpRequest(r, true)
		// log.Println(r.RequestURI)
		log.Println(string(data))

		// Call the next handler, which can be another middleware in the chain, or the final handler.
		next.ServeHTTP(w, r)
	})
}

var listenPort = flag.String("p", "5757", "port")
var bogMesTest = flag.Int( "t" , 0 , "for loadtesting ONLY!!! send bot msg right now" )
var verbose = flag.Int( "v" , 0 , "verbose" )

var GitCommit string = "fakecommit"

func main() {
	runtime.GOMAXPROCS(1)
	defer dbconn.RedisClose()

    MaxOpenFiles() 

	flag.Parse()

    event.LoadEvents()
    StartWorker() 

	r := mux.NewRouter()
	r.HandleFunc( "/info", infoHandle).Methods("GET")
	r.HandleFunc( "/bot", webhookHandleGET).Methods("GET")
	r.HandleFunc( "/bot", webhookHandlePOST).Methods("POST")
	r.HandleFunc( "/debug", debugHandle )

	r.HandleFunc("/", catchAllHandler)

    go func() {
        log.Println(http.ListenAndServe(":6060", nil))
    }()

    if runtime.GOOS == "darwin" || *verbose == 1 {
        log.SetFlags(log.LstdFlags | log.Lshortfile)
        r.Use(loggingMiddleware)
    }

	log.Println("listening on", *listenPort, "git commit:", GitCommit  )
	http.ListenAndServe(":"+*listenPort, r)

}
