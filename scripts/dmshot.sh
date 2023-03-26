#!/bin/sh
#  _  _ ___
# | || | __|   P
# | __ | _|     
# |_||_|___|   J
#

# sent notification {{{
notify() {
	case $3 in
		1) mode=low ;;
		2) mode=normal ;;
		3) mode=critical ;;
		*) mode=normal ;;
	esac

	notify-send -u ${mode} -a ${prompt} \
		-i accessories-screenshot "${1}" "${2}"

	if [ -z ${2} ]; then
		printf '%s\n' "${1}"
	else
		printf '%s: %s\n' "${1}" "${2}"
	fi
}
# }}}
# variables {{{
directory="${HOME}/screen/shots"
stamp=$(date '+%y%m%d_%H%M%S')
name="${directory}/shot-${stamp}.png"
prompt=$(echo $0 | awk -F '/' '{print $NF;}')
patched='-c -g 2 -bw 2 -l 2'
runner="dmenu \
		-p ${prompt} \
		-i \
		${patched} \
		${@} \
		"

# main choice
choice=$(printf '%s\n' \
	"whole screen" "active window" "select area" "quit" \
		| ${runner} \
		| awk '{print $1}')

if [ -z "${choice}" ]; then
	notify "Shot canceled." '' 1
	exit 0
fi

quality="5"
shooter="maim --hidecursor -m ${quality}"
#execarg="mv \$f ${directory}/; nsxiv ${directory}/\$f & printf ${directory}/\$f | xclip -selection c "
# }}}

# main {{{
if [ ! -d "${directory}" ]; then
	mkdir -p "${directory}"
fi

case ${choice} in
	quit)
		exit 0
		;;
	whole)
#		# scrot (broken for dual-monitor) {{{
		#Monitor=":0.0+0,1080"
		#${scrot} -p ${quality} \
		#	${mon} 'shots-%y%m%d_%H%M%S_$wx$h.png' \
		#	-e "mv \$f ${directory}/; r.sh nsxiv ${directory}/\$f; printf ${directory}/\$f | xclip -selection c "
#		# }}}
		# vars {{{
		DemResTmp=$(xdpyinfo | grep dimensions | awk '{print $2;}')
		DemResX=$(echo "${DemResTmp}" | sed 's/x.*//')
		DemResY=$(echo "${DemResTmp}" | sed -e 's/.*x//' -e 's/$/ \/ 2/' | bc)

#		if [ -z "${#}" ]; then
			monitor=$(printf '%s\n' '↓' '↑' '↕' '→' \
					| ${runner} -p monitor)
#		fi

		case ${monitor} in
			'↑') DemRes="-g ${DemResX}x${DemResY}+0+0" ;;
			'↓') DemRes="-g ${DemResX}x${DemResY}+0+${DemResY}" ;;
			'↕') DemRes="-g ${DemResTmp}" ;;
			'—') notify "Shot canceled." '' 1; exit 0; ;;
			*) notify "Shot canceled." '' 1; exit 1; ;;
		esac
		# }}}
		${shooter} ${DemRes} ${name}
		;;
	active)
#		# scrot (broken for dual-monitor) {{{
#		${scrot} -p ${quality} \
#			${mon} -u 'shots-%y%m%d_%H%M%S_$wx$h.png' \
#			-e "mv \$f ${directory}/; r.sh nsxiv ${directory}/\$f; printf ${directory}/\$f | xclip -selection c "
#		# }}}
		${shooter} -i $(xdotool getactivewindow) ${name}
		;;
	select)
#		# scrot (broken for dual-monitor) {{{
#		${scrot} -p ${quality} \
#			${mon} -s 'shots-%y%m%d_%H%M%S_$wx$h.png' \
#			-e "mv \$f ${directory}/; r.sh nsxiv ${directory}/\$f; printf ${directory}/\$f | xclip -selection c "
#		# }}}
		${shooter} -s ${name}
		;;
	*)
		notify "Shot canceled." '' 1
		exit 1
		;;
esac

notify "Screenshot taken" "${name}"

nsxiv "${name}" &

tocopy=$(printf '%s\n' "image" "path" | ${runner} -l 1)
case ${tocopy} in
	image)
		cat ${name} | xclip -selection clipboard -t image/png
		;;
	path)
		echo ${name} | tr -d '\n' | xclip -selection clipboard
		;;
	*)
		echo ${name} | xclip -selection clipboard
		;;
esac

# }}}
