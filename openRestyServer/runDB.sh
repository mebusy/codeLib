
dbName=hdadb

if [ "$(docker ps -aq -f name=${dbName})" ]; then
    echo 'run an existing db '
    docker stop ${dbName} > /dev/null 
    docker start ${dbName} > /dev/null
else
    echo 'run a new db instance '

mkdir -p DB/data

# docker rm -f ${dbName}
docker run --name ${dbName} --net=host -e MYSQL_ROOT_PASSWORD=pwd -d \
    -v `pwd`/DB/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d \
    -v `pwd`/DB/data:/var/lib/mysql \
    mysql:5.7

fi


