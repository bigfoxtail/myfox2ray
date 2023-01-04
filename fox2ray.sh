#!/bin/bash

cd `dirname $0`

blue(){
    echo -e "\033[36;1m${@}\033[0m"
}
green(){
    echo -e "\033[32;1m${@}\033[0m"
}
red(){
    echo -e "\033[31;1m${@}\033[0m"
}
yellow(){
    echo -e "\033[33;1m${@}\033[0m"
}

get_char()
{
    SAVEDSTTY=`stty -g`
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

function start_menu(){
    clear
    green " ====================================================="
    if [ ! -d "./server/" ];then
        red " 请先运行init.sh初始化项目"
        char=`get_char`
        exit 1
    fi
    green " 描述：Fox2ray简易管理脚本"
    green "     提供在docker中管理xray和caddy的基本功能"
    green " 作者：fox"
    echo
    green " 1. 部署 fox2ray"
    green " 2. 启动 fox2ray"
    green " 3. 更新 fox2ray"
    green " 4. 部署 fox2ray + (caddy)"
    green " 5. 启动 fox2ray + (caddy)"
    green " 6. 更新 fox2ray + (caddy)"
    green " 7. 停止 fox2ray"
    green " 8. 移除 fox2ray"
    yellow " 0. Exit"
    echo
    read -p "输入数字:" num
    case "$num" in
    1)
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" build --pull
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" up --no-start
    ;;
    2)
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" start
    ;;
    3)
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" pull
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" down
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" up -d
    ;;
    4)
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" build --pull
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" --profile http up --no-start
    ;;
    5)
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" --profile http start
    ;;
    6)
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" --profile http pull
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" --profile http down
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" --profile http up -d
    ;;
    7)
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" --profile http stop
    ;;
    8)
    docker-compose -f ./server/docker-compose.yml -p "fox2ray" --profile http down
    ;;
    0)
    exit 1
    ;;
    *)
    clear
    red "请输入正确的序号"
    sleep 2s
    start_menu
    ;;
    esac
    start_menu
}

start_menu
