#!/usr/bin/env bash

# Variables {{{
[[ -z $1 ]] && bg='#ff7700' || bg="$1"
[[ -z $2 ]] && fg='#300a24' || fg="$2"
[[ -z $3 ]] && nf='#fdf6e3' || nf="$3"

script_name=$(echo $0 | awk -F '/' '{print $NF;}')
dmenu="dmenu \
		-sb ${bg} -sf ${fg} \
		-nf ${nf} -nb ${fg} \
		-i -c -l 30 -g 1 \
        -p ${script_name}"
# }}}
# sent notification {{{
notify() {
    #icon='-i none'
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

	notify-send -u $mode -a ${script_name} ${icon} "${1}"
}
# }}}


