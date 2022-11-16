GIT_COMMIT=$(git rev-list -1 HEAD)

echo "gitcommit:" $GIT_COMMIT

TARGET=goproxy
GOOS=linux GOARCH=amd64 go build -ldflags "-w -X main.GitCommit=$GIT_COMMIT"  -o $TARGET

mv $TARGET ./image
