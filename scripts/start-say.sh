#!/bin/bash
#  _  _
# | || |
# | __ |
# |_||_|
#
set -e

pkg="xbps-query -l"

mem=$(free -h | grep ^Mem | awk '{print $3"/"$2;}')
pkgs=$($pkg | wc -l)
uptime=$(uptime | awk '{print $3;}' | sed 's/,//')
date=$(date '+%H:%M %a %y-%m-%d')
kernel=$(uname -r)

printf '%s\n' \
	"${date}, Uptime: ${uptime}" "" \
	"Memory: ${mem}, User: ${USER}" "" \
	"Packages: ${pkgs}, Kernel: ${kernel}" "" \
| cowsay -f tux # | lolcat
