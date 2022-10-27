#!/bin/sh

Color_Text()
{
  echo -e " \e[0;$2m$1\e[0m"
}

Echo_Red()
{
  echo $(Color_Text "$1" "31")
}

Echo_Green()
{
  echo $(Color_Text "$1" "32")
}

Echo_Yellow()
{
  echo $(Color_Text "$1" "33")
}

Echo_Blue()
{
  echo $(Color_Text "$1" "34")
}

Echo_Green 'check netwrok'
docker network ls | grep fox2ray_default > /dev/null
if [ $? -ne 0 ]; then
        Echo_Green 'create netwrok'
        docker network create fox2ray_default
fi
Echo_Green 'check container'
docker ps | grep portainer > /dev/null
if [ $? -eq 0 ]; then
        Echo_Green 'rm container'
        docker stop portainer
        docker rm portainer
fi
Echo_Green 'pull image'
docker pull cr.portainer.io/portainer/portainer-ce
Echo_Green 'run container'
docker run -d --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    cr.portainer.io/portainer/portainer-ce
Echo_Green 'join netwrok'
docker network connect fox2ray_default portainer
Echo_Green 'completed'
