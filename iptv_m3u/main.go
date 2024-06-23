package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"regexp"
	"strconv"
	"strings"
	"sync"
)

func main() {
	// http GET https://iptv-org.github.io/iptv/index.m3u
	resp, err := http.Get("https://iptv-org.github.io/iptv/countries/cn.m3u")
	if err != nil {
		fmt.Println("get cn m3u Error: ", err)
		return
	}
	defer resp.Body.Close()
	// read all
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		fmt.Println("read cn m3u Error: ", err)
		return
	}
	// read lines
	lines := strings.Split(string(body), "\n")

	re := regexp.MustCompile(`group-title=".*?",([^\(\n]+)?(?:\((\d+)p\))?`)

	// create a wait group
	m3uList := make([]*M3U, 0, len(lines)/2)
	var wg sync.WaitGroup
	// buffered channel
	for i := 1; i < len(lines); i += 2 {
		// fmt.Println(lines[i])
		if len(lines[i]) == 0 {
			continue
		}
		info := lines[i]
		// re caputre group
		match := re.FindStringSubmatch(info)
		if len(match) <= 1 {
			// continue
			fmt.Printf("Error: can not match reg %s\n", info)
			continue
		}

		var m3u M3U
		m3uList = append(m3uList, &m3u)
		m3u.Info = info
		m3u.Url = lines[i+1]
		m3u.Titile = strings.TrimSpace(match[1])
		if len(match) == 3 {
			m3u.Resolution, _ = strconv.Atoi(match[2])
		} else {
			m3u.Resolution = 4096
		}

		wg.Add(1)

		checkReachability(&m3u, &wg)

		// fmt.Printf("%+v\n", m3u)
	}

	wg.Wait()

	availableM3uList := make([]string, 0, len(m3uList))
	availableM3uList = append(availableM3uList, lines[0])
	for _, m3u := range m3uList {
		if m3u.Available {
			// fmt.Printf("%s: %s\n", m3u.Titile, m3u.Url)
			availableM3uList = append(availableM3uList, m3u.Info)
			availableM3uList = append(availableM3uList, m3u.Url)
		}
	}
	// write to file ./cn.m3u
	err = os.WriteFile("./cn.m3u", []byte(strings.Join(availableM3uList, "\n")), 0644)
	if err != nil {
		fmt.Println("Write File Error: ", err)
		return
	}

	fmt.Println("done")
}
