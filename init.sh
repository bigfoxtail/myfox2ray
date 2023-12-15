#!/bin/sh

cd `dirname $0`

if [ ! -d "./server/caddy_data" ];then
  mkdir -p ./server/caddy_data
fi
cp ./template/docker-compose-template.yml ./server/docker-compose.yml
cp ./template/xray_server.json ./server/xray_server.json
cp ./template/Caddyfile ./server/Caddyfile
cp ./template/xray_run.sh ./server/xray_run.sh
cp -r ./template/caddy-docker ./server/
cp -r ./template/site ./server/
cp -r ./template/caddy_data/* ./server/caddy_data

DOMAIN=*.flow.qq.com
Xray_UUID=00000000-0000-0000-0000-000000000000
REVERSE_PROXY_INFO=https://gamer.qq.com
FALLBACK_INFO=caddy:80

if [ -f ./fox2ray.properties ]; then
    . ./fox2ray.properties
fi

Xray_CERTPATH=./caddy_data/caddy/certificates/

sed -i "s|CADDY_DOMAIN|$DOMAIN|g" ./server/Caddyfile
sed -i "s|REVERSE_PROXY_INFO|$REVERSE_PROXY_INFO|g" ./server/Caddyfile

sed -i "s/Xray_UUID/$Xray_UUID/g" ./server/xray_server.json
sed -i "s/FALLBACK_INFO/$FALLBACK_INFO/g" ./server/xray_server.json

#Xray_SSLCERT=/config/certificates/$DOMAIN.crt
#Xray_SSLKEY=/config/certificates/$DOMAIN.key
#sed -i "s#/path/to/certificate.crt#$Xray_SSLCERT#" ./server/xray_server.json
#sed -i "s#/path/to/private.key#$Xray_SSLKEY#" ./server/xray_server.json
sed -i "s#Xray_CERTPATH#$Xray_CERTPATH#" ./server/docker-compose.yml
sed -i "s/CADDY_DOMAIN/$DOMAIN/" ./server/xray_run.sh
