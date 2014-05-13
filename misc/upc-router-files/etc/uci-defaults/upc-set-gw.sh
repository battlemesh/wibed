#!/bin/sh

echo "Configuring Wibed gateway"

uci batch << EOF
set network.loopback.dns="8.8.8.8"
set network.upc="route"
set network.upc.target="147.83.0.0"
set network.upc.netmask="255.255.0.0"
set network.upc.gateway="10.8.10.9"
set network.upc.interface="wan"
set network.wan="interface"
set network.wan.ifname="eth0.2"
set network.wan.proto="static"
set network.wan.ipaddr="10.8.10.10"
set network.wan.netmask="255.255.255.248"
set wibed.management.is_gw="1"
commit
EOF

echo "sh /root/upc-set-gre.sh" >> /etc/rc.local
sed -i s/"exit 0"//g /etc/rc.local
