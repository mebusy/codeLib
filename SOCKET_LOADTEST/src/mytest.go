package main

import (
    "flag"        
    "log"
    "os"
    "fmt"
    "github.com/monnand/goredis"
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
)

var testType  = flag.String ( "t" , "redis"  , "test type: redis/" )

func main() {
    flag.Parse()
    log.Println( "done" )

    switch *testType {
    case "redis":
        testRedis()    
    case "mysql":
        testMysql()
    }
}


func testRedis() {
    host := os.Getenv( "REDIS_HOST" )    
    pwd := os.Getenv( "REDIS_PASSWORD" )    
    log.Print( host, pwd  )
    client:= goredis.Client{}
    client.Addr = fmt.Sprintf( "%s:6379" , host )
    result, err :=  client.Incr( "inc" )
    if err!=nil {
        log.Fatal( err  )
    }
    log.Println( result  ,  "after incr" )
    
}

func testMysql() {
    host := os.Getenv( "MYSQL_HOST" )        
    user := os.Getenv( "MYSQL_USER" )
    pwd := os.Getenv( "MYSQL_PASSWORD" )
    mdb := os.Getenv( "MYSQL_DB" )
    
    url:= fmt.Sprintf( "%s:%s@tcp(%s:3306)/%s" , user, pwd,  host ,  mdb  ) 
    log.Println( "url:",  url  )
    db, err := sql.Open("mysql", url  )
    if err != nil {
        log.Fatal( err )
    }

    result , err := db.Exec( "show tables" ) ;
    if err != nil {
        log.Fatal( err )
    }
    log.Println( result  )
    

}
