#!/bin/bash
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

# Variables {{{
#patched='-c -bw 2'
dmenu="dmenu \
		-i \
		-l 25 \
		${patched} \
		${@} \
		"
prompt="$(echo $0 | awk -F '/' '{print $NF;}')"
#prompt="Kill"
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

	notify-send -a ${prompt} -i xfce-mount -u $mode "${1}"
}
# }}}

list=$( \
	ps --cols 120 axfo pid,%mem,%cpu,user,cmd  k %mem \
		| sed 's/  \\_ /  ├─ /' \
		| sed 's/|  /│  /g' \
		| sed 's/├─ -/├─ /' \
		| $dmenu -p "${prompt}" \
		| awk '{print $1;}'


	)

if [[ $list -eq 'PID' ]] || [[ -z $list ]]; then
	notify 'Canceled' 1
	exit 0
else
	thesig=$(printf '%s\n' \
		"15   SIGTERM   Terminate  " \
		"9    SIGKILL   Kill       (Not Safe)" \
		"2    SIGINT    Interrupt  " \
		"3    SIGQUIT   Quit       " \
		| $dmenu -p 'Send signal:' \
		| awk '{print $1;}')

	if [ -z "${thesig}" ]; then
		notify 'Canceled' 1
		exit 0
	else
		kill="kill -s $thesig"
	fi

	for i in $list
	do
		$kill "$i" \
			&& notify "Process [${i}] killed (signal ${thesig})" \
			|| notify "[${i}] Termination failed" 3
	done
fi
