#!/bin/sh
ip tunnel add a1 mode gre local 10.8.10.10 remote 147.83.30.197
ip addr add 192.168.100.2/24 dev a1
ip link set a1 up
iptables -A POSTROUTING -t nat -o a1 -j MASQUERADE

