#!/bin/sh
#  _  _ ___    
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#

# set -e

xset r rate 300 50 \
	&& notify-send -u low -a xrate.sh "Keypress dalay changed"

#setxkbmap -layout us,ir -option 'grp:lwin_toggle'
#setxkbmap -layout us,ir -option "grp:alt_shift_toggle"
setxkbmap -layout us,ir -option "grp:alt_caps_toggle" \
	&& notify-send -u low -a xrate.sh "Extra keyboard layout added"
