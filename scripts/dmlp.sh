#!/bin/sh
#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#
# Variables {{{
#script_name="Printer"
script_name=$(echo $0 | awk -F '/' '{print $NF;}')

#patched='-c -bw 4'
dmenu="dmenu \
		-i \
		-l 20 \
		-p "${script_name}" \
		${patched} \
		${@} \
		"
# }}}

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

	notify-send -u $mode -a ${script_name} -i printer "${1}"
}
# }}}
# main {{{
choice=$(printf '%s\n' \
	"Queue" \
	"Status" \
	"Quit" \
		| $dmenu \
		| awk '{print $1}')

case ${choice} in
	Queue)
		queue=$(lpstat | $dmenu | awk '{print $1;}')

		if [ ! -z $queue ]; then
			cancel ${queue} \
				&& notify "Queue ${queue} Got Canceled" \
				|| notify "Problem with ${queue}" 2
		else
			notify "Nothing is Selected" 1
		fi
	;;
	Status)
		lpc stat | sed 's/\t/    /g' | $dmenu
	;;
	Quit)
		exit 0
	;;
	*)
		notify "Canceled" 1
		exit 0
	;;
esac
# }}}
