
DIR_SCRIPT=../luatest/common_res/scripts

cp -f ./md5-1.1.2/src/*.lua ${DIR_SCRIPT} 

cp -f ./luasocket-2.0.2/*.lua  ${DIR_SCRIPT} 
cp -f ./luasocket-2.0.2/src/*.lua  ${DIR_SCRIPT} 

mkdir -p ${DIR_SCRIPT}/socket
cp -f ./luasocket-2.0.2/socket/*.lua  ${DIR_SCRIPT}/socket

