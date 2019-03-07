GIT_COMMIT=$(git rev-list -1 HEAD)

echo $GIT_COMMIT

TARGET=botserver
DIST_FOLDER="/Volumes/WORK/WORK/STACK/UMC-Common-Service"
go build -ldflags "-X main.GitCommit=$GIT_COMMIT"  -o $TARGET

mv -f $TARGET  $DIST_FOLDER 




