
serverName=hdaserver


if [ "$(docker ps -aq -f name=${serverName})" ]; then
    echo "run an existing server "
    docker stop ${serverName} > /dev/null
    docker start ${serverName} > /dev/null
else

echo "run a new server instance"
# docker rm -f ${serverName}

mkdir -p logs
mkdir -p staticRes/ads

chmod -R 777 staticRes

NET_CONFIG="--net=host" 
if [ `uname` == "Darwin" ] ; then
    NET_CONFIG="-p 9000:9000 -p 9011:9011 -p 9012:9012"
    echo ${NET_CONFIG}
fi

docker run --restart unless-stopped -d --name ${serverName} ${NET_CONFIG} --ulimit nofile=200000:200001 \
    -v `pwd`/conf/:/etc/nginx/conf.d/  \
    -v `pwd`/logs:/usr/local/openresty/nginx/logs \
    -v `pwd`/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
    -v `pwd`/lua/:/usr/local/openresty/nginx/lua/ \
    -v `pwd`/webTools/:/usr/local/openresty/nginx/webTools/ \
    -v `pwd`/staticRes/:/usr/local/openresty/nginx/staticRes/ \
    openresty/openresty:trusty

fi





