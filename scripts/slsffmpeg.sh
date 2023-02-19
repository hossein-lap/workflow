#!/bin/sh
#  _  _
# | || |
# | __ |
# |_||_|
#
#set -e

pcount=$(ps aux | grep '\<ffmpeg\>' | grep "${HOME}/screen/record" -c)

if [ "$pcount" -eq 1 ]; then
	printf ' [recording]'
elif [ "$pcount" -gt 1 ]; then
	printf " [recording(${pcount})]"
else
	#dunstify -u normal "simple test is here"
	printf ""
fi
