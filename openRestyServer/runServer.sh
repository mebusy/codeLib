
serverName=hdaserver

if [ "$(docker ps -aq -f name=${serverName})" ]; then
    echo "run an existing server "
    docker stop ${serverName} > /dev/null
    docker start ${serverName} > /dev/null
else

echo "run a new server instance"
# docker rm -f ${serverName}
mkdir -p logs
docker run -d --name ${serverName} --net=host \
    -v `pwd`/conf/:/etc/nginx/conf.d/  \
    -v `pwd`/logs:/usr/local/openresty/nginx/logs \
    -v `pwd`/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
    -v `pwd`/lua/:/usr/local/openresty/nginx/lua/ \
    -v `pwd`/webTools/:/usr/local/openresty/nginx/webTools/ \
    openresty/openresty:trusty

fi




