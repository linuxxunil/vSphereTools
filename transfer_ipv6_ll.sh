#!/bin/sh
nic=eth0
ipv6_prefix=fd01
mac_addr=$(cat /sys/class/net/${nic}/address)

mac_to_ipv6_ll() {
    IFS=':'; set $1; unset IFS
    ipv6=$(echo "${ipv6_prefix}::$(printf %02x $((0x$1 ^ 2)))$2:${3}ff:fe$4:$5$6")
    echo ${ipv6}
}

result=$(mac_to_ipv6_ll ${mac_addr})
ip -6 addr add $result/64 dev ${nic}
