#!/bin/sh

set -e

# to show all route rules
# netstat -rn

# if not Darwin, then exit
if [ "$(uname)" != "Darwin" ]; then
  echo "[WARN] This script is only for macOS"
  exit 1
fi

porxyHost=localhost
port=3127

curDir=$(dirname $0)
logPath=${curDir}/tun2socks.log

# determine binary name based on the platform
# e.g. tun2socks-darwin-amd64 , tun2socks-darwin-arm64
arch=$(uname -m)
tun2socks_bin="tun2socks-darwin-${arch}"

echo "[INFO] tun2socks binary: ${tun2socks_bin}" >> ${logPath}

kill_tun2socks() {
  if [ -n "$(pgrep ${tun2socks_bin})" ]; then
    echo "[INFO] kill existing tun2socks process" > ${logPath}
    pkill ${tun2socks_bin}
    sleep 1
    if [ -n "$(pgrep ${tun2socks_bin})" ]; then
      echo "[ERROR] failed to kill existing tun2socks process" > ${logPath}
    fi
  fi
}

gateway=$(route -n get default | grep 'gateway' | awk '{print $2}')
# get the first 2 octets of the gateway e.g. 192.168
gatewayPrefix=$(echo ${gateway} | cut -d'.' -f1-2)
# echo ${gatewayPrefix}


tunNets="1.0.0.0/8 2.0.0.0/7 4.0.0.0/6 8.0.0.0/5 16.0.0.0/4 32.0.0.0/3 64.0.0.0/2 128.0.0.0/1 198.18.0.0/15"

add_routes() {
  sudo route add -net 127.0.0.0/8 127.0.0.1 &> ${logPath} 
  echo "[INFO] add route  127.0.0.0/8 127.0.0.1" > ${logPath}
  sudo route add -net ${gatewayPrefix}.0.0/16 ${gateway} &> ${logPath}
  echo "[INFO] add route ${gatewayPrefix}.0.0/16 ${gateway}" > ${logPath}

  for net in ${tunNets}; do
    sudo route add -net ${net} 198.18.0.1 &> ${logPath}
  done
}

clean_routes() {
  for net in ${tunNets}; do
    sudo route delete -net ${net} &> ${logPath}
  done 

  sudo route delete 127.0.0.0/8  &> ${logPath}
  sudo route delete ${gatewayPrefix}.0.0/16  &> ${logPath}
}

# if v2raya socks5 port ${port} is not listening, then exit
# if [ -z "$(lsof -i:${port} | grep LISTEN)" ]; then
if [ -z "$(lsof -i:${port} | grep LISTEN)" ]; then
  echo "[INFO] v2raya socks5 port ${port} is not listening" > ${logPath}

  kill_tun2socks

  clean_routes

  exit 1
else
    
  kill_tun2socks

  ${curDir}/tun2socks/${tun2socks_bin} -device utun123  -interface en0 -proxy http://${porxyHost}:${port} > ${logPath}  &

  sleep 3

  sudo ifconfig utun123 198.18.0.1 198.18.0.1 up

  clean_routes

  add_routes

fi

