package main

import (
	"net/http"
	"sync"
	"time"
)

type M3U struct {
	Info       string
	Url        string
	Titile     string
	Resolution int
	Available  bool
}

var checkingChannel = make(chan int, 32)

func checkReachability(m3u *M3U, wg *sync.WaitGroup) {
	checkingChannel <- 1

	go func() {
		// set http client timeout to 5 seconds
		println("checkReachability: ", m3u.Titile)
		client := &http.Client{
			Timeout: 5 * time.Second,
		}
		resp, err := client.Get(m3u.Url)
		if err != nil {
			m3u.Available = false
		} else {
			m3u.Available = resp.StatusCode == 200
			// if m3u.Available {
			// 	println(m3u.Url)
			// }
			resp.Body.Close()
		}

		<-checkingChannel
		wg.Done()
	}()
}
