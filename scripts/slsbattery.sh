#!/bin/sh
#  _  _
# | || |
# | __ |
# |_||_|
#

status=$(acpi -b | awk '{print $3}' | sed 's/[%,]//g')
percent=$(acpi -b | awk '{print $4}' | sed 's/[%,]//g')
args="-a $(echo "$0" | awk -F '/' '{print $NF;}') -i battery"

if [ $status = 'Discharging' ] && [ $percent -lt 6 ]; then
	time=$(echo "`date +%s` % 30" | bc)
	if [ "$time" -eq '0' ]; then
		#mpv --really-quiet ~/mus/sounds/notify/alert.wav &
		dunstify $args -u critical "Baterry is dying: ${percent}%"
	fi
elif [ $status = 'Full' ]; then
	time=$(echo "`date +%s` % 300" | bc)
	if [ "$time" -eq '0' ]; then
		#mpv --really-quiet ~/mus/sounds/notify/normal.wav &
		dunstify $args -u normal "Baterry is full: ${percent}%"
	fi
else
	percent=$(acpi -b | awk -F '%' '{print $1;}' | awk '{print $NF"%"}')
fi

printf '%s' "${percent}"
#printf '%s\n' "$status"
#elif [ $status = 'Full' ] && [ $percent = 100 ]; then
	#dunstify $args -u low "Baterry is fully charged"
