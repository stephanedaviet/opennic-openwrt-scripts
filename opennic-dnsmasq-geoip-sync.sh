#!/bin/ash

set -e
set -o pipefail

logger "Starting synchronisation of OpenNIC DNS servers..."

# Enable ISP DNS servers (to be able to resolve opennicproject.org)
# Another and more privacy friendy option is to access the API directly with the server IP
uci set network.wan.peerdns='1'
uci commit network        
/etc/init.d/network reload     
                                                                                               
# Disable ISP DNS servers (only safe way to disable ISP, DNSMasq DNS forwarding doesn't really work)
uci set network.wan.peerdns='0'                                                                
# Set DNS servers (uci set and not uci add_list as stated in some eroneous docs)               
uci set network.wan.dns="`curl "https://api.opennicproject.org/geoip/?bare&pct=90&bl" | xargs`"
uci commit network                                               
/etc/init.d/network reload                                       
                                                                 
logger "Synchronisation of OpenNIC DNS servers successfully done"
