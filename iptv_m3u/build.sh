#!/bin/sh

set -e 

GOOS=linux GOARCH=arm CGO_ENABLED=0 go build -o m3ucheck  -ldflags="-s -w" .

