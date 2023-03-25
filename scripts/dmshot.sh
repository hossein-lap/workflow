#!/bin/sh
#  _  _ ___
# | || | __|   P
# | __ | _|     
# |_||_|___|   J
#
#
#if [ -z "$1" ]; then
	#themon=''
#else
	#themon="-m $1"
#fi

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
	printf '%s\n' "Screenshot taken: ${1}"
}
# }}}
# variables {{{
patched='-c -g 2 -bw 2 -l 2 '
dmenu="dmenu \
		-i \
		${patched} \
		${@} \
		"
script_name=$(echo $0 | awk -F '/' '{print $NF;}')

choice=$(printf '%s\n' \
	"whole screen" "active window" "area" "quit" \
		| ${dmenu} -p ${script_name} \
		| awk '{print $1}')

if [ -z "${choice}" ]; then
	notify "Shot canceled." 1
	exit 0
fi
monitor=$(printf '%s\n' '0' '1' 'all' 'cancel' \
		| ${dmenu} -p monitor -l 2 -g 2)

case ${monitor} in
	'0')
		mon="-M 0"
		;;
	'1')
		mon="-M 1"
		;;
	all)
		mon=''
		;;
	cancel)
		notify "Shot canceled." 1
		exit 0
		;;
	*)
		notify "Shot canceled." 1
		exit 1
		;;
esac
alias notify="${notify}"

directory="${HOME}/screen/shots"
scrot="scrot"
quality="-q 60"
execarg="mv \$f ${directory}/; nsxiv ${directory}/\$f & printf ${directory}/\$f | xclip -selection c "
#shooter="${scrot} -p ${quality} ${mon}"
# }}}
# main {{{

if [ ! -d "${HOME}/screen/shots" ]; then
	mkdir -p ${HOME}/screen/shots
fi

case ${choice} in
	quit)
		exit 0
		;;
	whole)
		${scrot} -p ${quality} \
			${mon} 'shots-%y%m%d_%H%M%S_$wx$h.png' \
			-e "mv \$f ${directory}/; r.sh nsxiv ${directory}/\$f; printf ${directory}/\$f | xclip -selection c "
		;;
	active)
		${scrot} -p ${quality} \
			-u 'shots-%y%m%d_%H%M%S_$wx$h.png' \
			-e "mv \$f ${directory}/; r.sh nsxiv ${directory}/\$f; printf ${directory}/\$f | xclip -selection c "
		;;
	area)
		${scrot} -p ${quality} \
			-s 'shots-%y%m%d_%H%M%S_$wx$h.png' \
			-e "mv \$f ${directory}/; r.sh nsxiv ${directory}/\$f; printf ${directory}/\$f | xclip -selection c "
		;;
	*)
		notify "Shot canceled." 1
		exit 1
		;;
esac
#notify "Screenshot taken. ${fullpath}"
# }}}
