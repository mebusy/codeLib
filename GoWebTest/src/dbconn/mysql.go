package dbconn 

import (
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
    "log"
    "fmt"
    "time"
    "runtime"
)

// Mysql:  The connection pool is managed by Go's database/sql package.
// 1. sql.Open won't create a connection to db right now, but only initialize a sql.DB object.  It actually create connection on the 1st query op.
// 2. sql.DB represents the abstract of database , not the connection!!! , if you want veriry the connection right now, use `Ping()` method.
// 3. sql.DB object returned by sql.Open is coroutine-safe
// 4. create a sql.DB object to every database 

// then how to check wheher the connection is reused ?
// 1 SET GLOBAL general_log = 'ON'
// 2 SET GLOBAL log_output = 'TABLE'
// now you can find the mysql operation log in `mysql.general_log` table
// if the connection is reused, you should see the `connection` event only at the very beginning

var _db_mysql  *sql.DB 

func getMysqlDB() *sql.DB  {
    if _db_mysql == nil {
        // log.Println( mysql_user, mysql_password,  mysql_host ,  mysql_db )
        url:= fmt.Sprintf( "%s:%s@tcp(%s:3306)/%s" , mysql_user, mysql_password,  mysql_host ,  mysql_db  ) 
        // log.Println( "url:",  url  )    
        if db, err := sql.Open("mysql", url  ) ; err !=nil {
            log.Fatalln( err ) 
        } else {
            db.SetConnMaxLifetime(time.Minute*5);
            db.SetMaxIdleConns( 10 * runtime.GOMAXPROCS(0) );
            db.SetMaxOpenConns( 10 * runtime.GOMAXPROCS(0) );
            _db_mysql = db
        }
    }
    // this function should NOT return nil
    return _db_mysql
}

// if the mysql server is down
// db.Exec will return an error "invalid connection" , and pool will be clear
// new connection will be created if the server is online again
func MysqlTest() {
    db := getMysqlDB() 

    res, _ := db.Query("SHOW TABLES")
    var table string

    for res.Next() {
        res.Scan(&table)
        log.Println(table)
    }
}

// call `defer dbconn.MysqlClose()` 
// in main()
func MysqlClose() {
    db := getMysqlDB() 
    db.Close()    
}



