GIT_COMMIT=$(git rev-list -1 HEAD)

echo "gitcommit:" $GIT_COMMIT

TARGET=botserver
DIST_FOLDER="/Volumes/WORK/WORK/STACK/UMC-Common-Service"
GOOS=linux GOARCH=arm64 go build -ldflags "-X main.GitCommit=$GIT_COMMIT"  -o $TARGET

mv -f $TARGET  $DIST_FOLDER 




