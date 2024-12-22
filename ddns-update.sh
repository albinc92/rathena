#!/bin/bash

# Fetch WAN IP address
WAN_IP=$(curl -s https://ipinfo.io/ip)
if [ -z "$WAN_IP" ]; then
    echo "Error: Unable to fetch WAN IP" >> /var/log/ddns-update.log
    exit 1
fi

# Configuration file directory
IMPORT_TMPL="/conf/import-tmpl/"

# Check if the configuration directory exists
if [ ! -d "$IMPORT_TMPL" ]; then
    echo "Error: Configuration directory not found" >> /var/log/ddns-update.log
    exit 1
fi

# Update WAN IP in char_conf.txt
sed -i "s/^char_ip: =.*/char_ip: =$WAN_IP/" "$IMPORT_TMPL/char_conf.txt" || {
    echo "Error: Failed to update char_conf.txt" >> /var/log/ddns-update.log
    exit 1
}

# Update WAN IP in map_conf.txt
sed -i "s/^map_ip: =.*/map_ip: =$WAN_IP/" "$IMPORT_TMPL/map_conf.txt" || {
    echo "Error: Failed to update map_conf.txt" >> /var/log/ddns-update.log
    exit 1
}

# Dynamic DNS update URL
DDNS_URL="https://ipv4.cloudns.net/api/dynamicURL/?q=ODU3NzQ0NTo1NjI0NTA5MjU6MmU0YmViN2ZhN2ZjYmE2ZDlhM2IwYTRjNWUzZWFjODQ0MzI1ZjMxZWZmOGFkZjZkNmFlYzQ3YjYyZjM2Y2RjYQ"

# Update Dynamic DNS record
wget -q --read-timeout=0.0 --waitretry=5 --tries=400 --background "$DDNS_URL" || {
    echo "Error: Failed to update Dynamic DNS record" >> /var/log/ddns-update.log
    exit 1
}

# Reboot rAthena
./athena-start restart login-server
./athena-start restart char-server
./athena-start restart map-server

# Log success
echo "Script executed successfully at $(date)" >> /var/log/ddns-update.log
