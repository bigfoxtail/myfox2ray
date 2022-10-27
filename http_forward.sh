
REMOTE_IP="93.184.216.34"
LOCAL_IP="`hostname -I | cut -d' ' -f1`"

if [ -f ./fox2ray.properties ]; then
    . ./fox2ray.properties
fi

cat > /etc/network/if-up.d/run-iptables << EOF
#!/bin/sh
iptables -t nat -A PREROUTING -4 -p tcp -d $LOCAL_IP --dport 80 -j DNAT --to-destination $REMOTE_IP:80
iptables -t nat -A POSTROUTING -4 -p tcp -d $REMOTE_IP --dport 80 -j MASQUERADE
iptables -t filter -A FORWARD -s $REMOTE_IP -j ACCEPT
iptables -t filter -A FORWARD -d $REMOTE_IP -j ACCEPT
EOF
chmod +x /etc/network/if-up.d/run-iptables
