TARGET=linux_udp_echo_server
DIST_FOLDER="."
GOOS=linux GOARCH=amd64 go build  -ldflags "-w "  -o $DIST_FOLDER/$TARGET udp.go 




