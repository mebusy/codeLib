package dbconn

import (
    "os"
    // "log"
)

var mysql_host string
var mysql_user string
var mysql_password string 
var mysql_db string 

func init() {

    mysql_host = os.Getenv( "MYSQL_HOST" )        
    mysql_user = os.Getenv( "MYSQL_USER" )
    mysql_password = os.Getenv( "MYSQL_PASSWORD" )
    mysql_db = os.Getenv( "MYSQL_DB" )

    if mysql_host == "" {
        mysql_host = "127.0.0.1"    
    }
    if mysql_user == "" {
        mysql_user = "root"    
    }

    _ = mysql_password
    _ = mysql_db 
    
}

