FROM golang:1.18-alpine AS builder

RUN set -e \
    && apk upgrade \
    && apk add jq curl git ca-certificates \
    && export version=$(curl -s "https://api.github.com/repos/caddyserver/caddy/releases/latest" | jq -r .tag_name) \
    && echo ">>>>>>>> ${version} <<<<<<<<" \
    && go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest \
    && xcaddy build ${version} --output /caddy \
        --with github.com/caddyserver/transform-encoder \
        --with github.com/caddyserver/replace-response


FROM alpine:3.15

RUN apk add --no-cache ca-certificates mailcap bash tzdata

RUN set -eux; \
	mkdir -p \
		/config/caddy \
		/data/caddy \
		/etc/caddy \
		/usr/share/caddy \
	; \
	wget -O /etc/caddy/Caddyfile "https://raw.githubusercontent.com/caddyserver/dist/master/config/Caddyfile"; \
	wget -O /usr/share/caddy/index.html "https://raw.githubusercontent.com/caddyserver/dist/master/welcome/index.html"

COPY --from=builder /caddy /usr/bin/caddy

# set up nsswitch.conf for Go's "netgo" implementation
# - https://github.com/docker-library/golang/blob/1eb096131592bcbc90aa3b97471811c798a93573/1.14/alpine3.12/Dockerfile#L9
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data

VOLUME /config
VOLUME /data

EXPOSE 80
EXPOSE 443
EXPOSE 2019

WORKDIR /srv

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
