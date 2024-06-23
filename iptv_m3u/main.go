package main

import (
	"fmt"
	"io"
	"net/http"
	"strings"
)

func main() {
	// http GET https://iptv-org.github.io/iptv/index.m3u
	resp, err := http.Get("https://iptv-org.github.io/iptv/countries/cn.m3u")
	if err != nil {
		fmt.Println("Error: ", err)
		return
	}
	defer resp.Body.Close()
	// read all
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		fmt.Println("Error: ", err)
		return
	}
	// read lines
	lines := strings.Split(string(body), "\n")
	for _, line := range lines {
		fmt.Println(line)
	}

	fmt.Println("done")
}
