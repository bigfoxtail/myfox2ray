#!/bin/sh

rm /etc/xray/startconfig.json
cp /etc/xray/config.json /etc/xray/startconfig.json
echo "Start Server"
/usr/bin/xray -config /etc/xray/startconfig.json
