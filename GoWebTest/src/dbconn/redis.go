package dbconn

import (
	"fmt"
	"log"
	// "time"
	// "sync"
	"github.com/go-redis/redis"
	"runtime"
)

var _db_redis *redis.Client

func GetRedis() *redis.Client {
	if _db_redis == nil {
		addr := fmt.Sprintf("%s:6379", redis_host)
		client := redis.NewClient(&redis.Options{
			Addr:     addr,
			Password: redis_password,             // no password set
			DB:       0,                          // use default DB
			PoolSize: 10 * runtime.GOMAXPROCS(0), // default:  10 * runtime.Num-CPU()
		})

		if client == nil {
			log.Fatal("redis client create failed !")
		}
		_db_redis = client
	}
	return _db_redis
}

func RedisTest() {
	client := getRedis()
	val, err := client.Incr("inc2").Result()
	if err != nil {
		log.Println(err)
	}
	log.Println("after incr:", val)
	status := client.PoolStats()
	// check the pool status , to verity whether the pool works
	log.Printf("%+v\n", status)
}

func RedisClose() {
	client := getRedis()
	client.Close()
}
