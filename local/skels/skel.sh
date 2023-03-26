#!/bin/sh
#  _  _ ___
# | || | __| P
# | __ | _|   
# |_||_|___| J
#

## varaibles {{{
#icon=""
#path="${HOME}/.local/hos/chars/emoji.txt"
#prompt=$(echo ${0} | awk -F '/' '{print $NF;}')
#patched="-bw 0 -g 4 -l 10"
#style=""
#eargs=""
## }}}
## help function {{{
#help() {
#cat << EOF
#${prompt}: select and copy emojies to clipboard
#
#usage: [-h] [-s style] [-e extra_args]
#
#	long format arguemts:
#	    --style      <style>
#	    --extra      <extra-arguemts>
#	    --help       print this message
#
#	style:
#	    • gui        use “dmenu” as run launcher (default)
#	    • tui        use “fzf” instead
#
#	extra:
#	    • specify extra arguments to the run launcher (dmenu or fzf)
#
#	running without any arguments:
#	    • the default behavior of the script is to use dmenu as default launcher
#
#EOF
#}
## }}}
## argument parsing {{{
#while [ "${#}" -gt 0 ]; do
#	case ${1} in
#		-s|--style)
#			style="${2}"
#			shift
#			;;
#		-e|--extra)
#			eargs="${2}"
#			shift
#			;;
#		-h|--help)
#			help
#			exit 0
#			;;
#		*)
#			echo "Unknown parameter passed: ${1}"
#			exit 1
#			;;
#	esac
#	shift
#done
## }}}
## launcher {{{
#if [ "${style}" = 'tui' ]; then
#	runner="fzf -i -m \
#			--reverse \
#			--border=sharp \
#			--info=inline \
#			--prompt=: \
#			--marker=* \
#			--header=${prompt} --header-first \
#			${eargs} \
#			"
#elif [ -z ${DISPLAY} ]; then
#	runner="fzf -i -m \
#			--reverse \
#			--no-unicode \
#			--info=inline \
#			--border=sharp --border-label=${prompt} \
#			--prompt=: \
#			--marker=* \
#			${eargs} \
#			"
#elif [ "${style}" = 'gui' ]; then
#	runner="dmenu -l 9 -p ${prompt} ${patched} ${eargs}"
#else
#	runner="dmenu -l 9 -p ${prompt} ${patched} ${eargs}"
#fi
## }}}
## notification function {{{
#notify() {
#	summary="${1}"
#	if [ -z "${2}" ] || [ "${2}" = 1 ] || [ "${2}" = 2 ] || [ "${2}" = 3 ]; then
#		case ${2} in
#			1) mode=low ;;
#			2) mode=normal ;;
#			3) mode=critical ;;
#			*) mode=normal ;;
#		esac
#		#msgbody="${3}"
#	else
#		case ${3} in
#			1) mode=low ;;
#			2) mode=normal ;;
#			3) mode=critical ;;
#			*) mode=normal ;;
#		esac
#		msgbody="${2}"
#	fi
#
#	if [ ${mode} = 'critical' ]; then
#		iferror="stderr"
##		icon='error'
#	else
#		iferror="stdout"
#	fi
#
#	if [ -n "${icon}" ]; then
#		noticon="-i ${icon}"
#	fi
#
#	if [ "${style}" = 'tui' ]; then
#		printf '[%s] %s\n' "${summary}" "${msgbody}" "${iferror}"
#	elif [ -z "${DISPLAY}" ]; then
#		echo "${@}" >/dev/null 2>&1
#	else
#		notify-send -a "${prompt}" -u ${mode} ${noticon} \
#			"${summary}" "${msgbody}" 2>/dev/null
#		printf '[%s] %s\n' "${summary}" "${msgbody}" >/dev/${iferror}
#	fi
#}
## }}}

