
DIST_NAME="minddb"
zip -r $DIST_NAME.zip \
    DB/docker-entrypoint-initdb.d/ \
    DB/my.cnf \
    runDB.sh > /dev/null

wait &&

echo 'done'
