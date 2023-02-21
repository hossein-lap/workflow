#!/bin/sh
set -e

null=♦

if [ -z ${1} ]; then
	dev=wlan0
else
	dev=$1
fi

lip=$(ip a \
	| grep ${dev} \
	| grep 'inet ' \
	| awk '{print $2;}' \
	| awk -F '/' '{print $1;}' \
	| awk -F '.' '{print $NF;}')

[ -z $lip ] && lip=$null

mess=$(ping -c 1 1.1.1.1 \
	| grep bytes \
	| grep -v PING \
	| awk -F '=' '{print $NF;}' \
	| grep '^[0-9]')

if [ $(echo $mess | awk '{print $NF}') = 'ms' ]; then
	ping=$(echo ",${mess}" | awk '{print $1;}')
else
	ping=
fi

printf "${lip}${ping}"

#sleep 2ping
