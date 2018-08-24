

dbName=minddb

# . lua/_db.config

mysql_user=root
mysql_pwd=mindpwd

# echo "${mysql_user}"
# echo "${mysql_pwd}"

if [ "$1" == "force" ] ; then
    docker rm -f ${dbName}
    # rm -rf DB/data 
fi

if [ "$(docker ps -aq -f name=${dbName})" ] ; then
    echo 'run an existing db '
    docker stop ${dbName} > /dev/null 
    docker start ${dbName} > /dev/null
else
    echo 'run a new db instance '

mkdir -p DB/data

NET_CONFIG="--net=host" 
if [ `uname` == "Darwin" ] ; then
    NET_CONFIG="-p 3306:3306"
    echo ${NET_CONFIG}
fi


# docker rm -f ${dbName}
# docker run --name ${dbName} --net=host -e MYSQL_ROOT_PASSWORD=pwd -d \
docker run --restart unless-stopped --name ${dbName} ${NET_CONFIG} -e MYSQL_USER="${mysql_user}"  -e MYSQL_ROOT_PASSWORD="${mysql_pwd}"  -d --ulimit nofile=100000:100001 \
    -v `pwd`/DB/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d \
    -v `pwd`/DB/data:/var/lib/mysql \
    -v `pwd`/DB/my.cnf:/etc/mysql/my.cnf \
    mysql:5.7 --character-set-server=utf8

fi


# how to run mysql client 

# docker exec -it mysql-container-name bash
# mysql -u root -p

