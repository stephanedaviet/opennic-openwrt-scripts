#!/bin/ash

set -e
set -o pipefail

logger "Starting synchronisation of OpenNIC DNS servers with DNSMasq..."

wget -qO /tmp/opennic-geoip-servers https://api.opennicproject.org/geoip/

sed -i 's/#.*//g' /tmp/opennic-geoip-servers

uci del dhcp.@dnsmasq[-1].server

cat /tmp/opennic-geoip-servers | while read serverIp ; do
    uci add_list dhcp.@dnsmasq[-1].server=$serverIp ;
done

uci commit dhcp

killall -s SIGHUP dnsmasq

logger "Synchronisation of OpenNIC DNS servers with DNSMasq successfully done"
