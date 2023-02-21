#!/bin/sh

# Variables {{{
patched='-c -bw 2 -g 2'
dmenu="dmenu \
		-i \
		-l 3 \
		${patched} \
		${@} \
		"
#script_name="Exit"
script_name="$(echo $0 | awk -F '/' '{print $NF;}')"
# }}}

choice=$(printf '%s\n' "cancel" "apply" "exit" "lock" "shutdown" "reboot" \
	| $dmenu -p $script_name)

case $choice in
	[lL]ock) slock ;;
	[eE]xit) kill -TERM $(pgrep xinit) ;;
	[aA]pply) kill -HUP $(pgrep dwm) ;;
	[sS]hutdown) sudo shutdown -h now ;;
	[rR]eboot) sudo reboot ;;
	[cC]ancel) exit 0 ;;
	*) exit 1 ;;
esac
