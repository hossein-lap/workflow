#!/bin/sh
#  _  _ ___    
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#

# set -e

xset r rate 300 50 \
	&& dunstify -u low -a xrate.sh "Keypress dalay changed"

#setxkbmap -layout us,ir -option 'grp:lwin_toggle'
#setxkbmap -layout us,ir -option "grp:alt_shift_toggle"
setxkbmap -layout us,ir -option "grp:alt_caps_toggle" \
	&& dunstify -u low -a xrate.sh "Extra keyboard layout added"
