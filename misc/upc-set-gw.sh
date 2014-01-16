#!/bin/sh

echo "Configuring Wibed gateway"

uci batch << EOF
set network.upc=route
set network.upc.target=0.0.0.0
set network.upc.netmask=0.0.0.0
set network.upc.gateway=10.8.10.9
set network.upc.interface=wan
set network.wan=interface
set network.wan.ifname=eth0
set network.wan.proto=static
set network.wan.ipaddr=10.8.10.10
set network.wan.netmask=255.255.255.248
set wibed.management.is_gw=1
commit
EOF

