#!/bin/sh
#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#
#
#if [ -z "$1" ]; then
	#themon=''
#else
	#themon="-m $1"
#fi

# Variables {{{
#patched='-c -g 2 -bw 2 -wm'
dmenu="dmenu \
		-i \
		-l 0 \
		${patched} \
		${@} \
		"

#script_name="ScreenShot"
script_name=$(echo $0 | awk -F '/' '{print $NF;}')
# }}}
scrot="scrot"
directory="$HOME/screen/shots"
execarg="mv \$f ${directory}/ & nsxiv ${directory}/\$f & printf ${directory}/\$f | xclip -selection c "
quality="-q 60"

# sent notification {{{
notify() {
	case $2 in
		1)
			mode=low
			;;
		2)
			mode=normal
			;;
		3)
			mode=critical
			;;
		*)
			mode=normal
			;;
	esac

	notify-send -u $mode -a ${script_name} -i accessories-screenshot "${1}"
}
# }}}
# main {{{
choice=$(printf '%s\n' \
	"whole screen" "active window" "area" "quit" \
		| $dmenu -p ${script_name} \
		| awk '{print $1}')

if [ ! -d "$HOME/screen/shots" ]; then
	mkdir -p $HOME/screen/shots
fi

case ${choice} in
	quit)
		exit 0
	;;
	whole)
		scrot 'shots-%y%m%d_%H%M%S_$wx$h.png' $quality -e "$execarg"
	;;
	active)
		scrot -u 'shots-%y%m%d_%H%M%S_$wx$h.png' $quality -e "$execarg"
	;;
	area)
		scrot -s 'shots-%y%m%d_%H%M%S_$wx$h.png' $quality -e "$execarg"
	;;
	*)
		notify "Shot canceled." 1
		exit 1
	;;
esac
notify "Screenshot taken. ${fullpath}"
# }}}
