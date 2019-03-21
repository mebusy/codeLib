package main

import (
    "net/http"
    "fmt"
    // "log"
    "strconv"
    "crypto/md5"
    "io"
    "dbconn"
)

func debugHandle(w http.ResponseWriter, r *http.Request) {
    msg := r.FormValue( "msg" )
    if msg != "" {
        i, err := strconv.Atoi( msg )
        if err != nil {
            fmt.Fprintf( w, fmt.Sprintf( "error request: %s" , err.Error() )  )     
            return 
        }
        dbconn.Set_QA_debugMsgID ( i )
    }


    s := fmt.Sprintf( "git commit: %s",  GitCommit   )
	h := md5.New()
	io.WriteString(h,  s )
    token_debug_enable :=  fmt.Sprintf( "%x", h.Sum(nil) )
    // log.Println( s, token_debug_enable )

    debug := r.FormValue( "enable" ) 
    if debug != "" {
        dbconn.Set_QA_debugEnabled ( debug == token_debug_enable )
    }

    if !dbconn.Get_QA_debugEnabled() {
        dbconn.Set_QA_debugMsgID ( -2 )
    }

    
	fmt.Fprintf(w, fmt.Sprintf("debug msg is: %d, %v" , dbconn.Get_QA_debugMsgID(), dbconn.Get_QA_debugEnabled_TTL()  )  )
}


