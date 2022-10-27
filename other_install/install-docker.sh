#!/bin/sh

if ! [ -x "$(command -v curl)" ]; then
  echo "curl could not be found"
  exit 1
fi

echo "docker install"
curl -fsSL https://get.docker.com | sh

echo "docker-compose install"
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo "compose V2 install"
mkdir -p /usr/local/lib/docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.0.1/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
docker compose version

echo "compose-switch install"
curl -fL https://raw.githubusercontent.com/docker/compose-switch/master/install_on_linux.sh | sh
update-alternatives --display docker-compose

echo "enable"
systemctl enable docker
systemctl start docker
