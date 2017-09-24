# OpenWRT script for OpenNIC setup

Those two little scripts provide the bare minimum to setup OpenNIC servers on an OpenWRT router:
* whitelisting of your IP to be able to query Tier 2 servers where whitelisting is enabled,
* synchronisation of your DNSMasq config with servers provided from the GeoIP API of OpenNIC.

A basic usage is to put those two scripts in `/opt` and setup a cron execution through `crontab -e` (replace placeholders with your username and token created on the OpenNIC site):

    # OpenNIC stuff
    # Register IP to be whitelisted on DNS lookups
    0 12 * * * /opt/opennic-whitelist.sh -u <user> -t <token>
    # Sync dnsmasq servers config from geoip OpenNIC API
    5 12 * * * /opt/opennic-dnsmasq-geoip-sync.sh`
