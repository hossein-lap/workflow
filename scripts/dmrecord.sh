#!/bin/bash
#  _  _
# | || |
# | __ |
# |_||_|
#
set -e

# Variables {{{
patched='-c -bw 2 -g 1'
dmenu="dmenu \
		-i \
		-l 5 \
		${patched} \
		${@} \
		"
#script_name="RecordScreen"
script_name=$(echo $0 | awk -F '/' '{print $NF;}')
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

	notify-send -a ${script_name} -i simplescreenrecorder -u $mode "${1}"
}
# }}}
extention="mkv"
audioCodec="aac"
framerate="30"
Directory="$HOME/screen/record"
Name=$(date +%y%m%d_%H%M%S)

# Kill {{{
stop_record () {
	pid=$(pgrep ffmpeg)
	thesig=$(printf '%s\n' \
		"2   SIGINT   Interrupt  Terminate" \
		"3   SIGQUIT  Quit       Terminate with core dump" \
		"9   SIGKILL  Kill       Forced termination" \
		"15  SIGTERM  Terminate  Terminate" \
		| $dmenu -p 'Send signal:' \
		| awk '{print $1;}')
	
	if [ -z "${thesig}" ]; then
		kill="kill -s 15"
	else
		kill="kill -s $thesig"
#		notify "$kill"
	fi

	if [ -z "${pid}" ]; then
		notify "Record canceled" 1
		exit 2
	else
		$kill "${pid}"
	fi
}
# }}}
# select window {{{
record_sel_window () {
	if [ ! -d "${Directory}" ]; then
		mkdir -p "${Directory}"
	fi

	WinId=$(xdotool selectwindow getwindowgeometry --shell \
		| grep WINDOW \
		| awk -F '=' '{print $NF;}')
	DemRes=$(xwininfo -id "${WinId}")
	OutRes=$(xdpyinfo | grep dimensions | awk '{print $2;}')
	PaDevOut=$(pactl list short sources | awk '{print $2;}' | grep output)
	PaDevIn=$(pactl list short sources | awk '{print $2;}' | grep input)
	
	xwininfo -id ${WinId} | {
	while IFS=: read -r k v; do
		case "$k" in
		*"Absolute upper-left X"*) x=$v;;
		*"Absolute upper-left Y"*) y=$v;;
		*"Border width"*) bw=$v ;;
		*"Width"*) w=$v;;
		*"Height"*) h=$v;;
		esac
	done
###
	case ${WithAudio} in
		mic)
		ffmpeg -y -f x11grab -r ${framerate} \
				-video_size "$((w))x$((h))" \
				-i "+$((x+bw)),$((y+bw))" \
				-f pulse \
				-ac 2 \
				-i default \
				-vcodec libx264 \
				-acodec ${audioCodec} \
				-pix_fmt yuv420p \
				-loglevel quiet -stats \
				"${Directory}/${BaseName}-${Name}.${extention}"
		;;
		sys)
		ffmpeg -y -f x11grab -r ${framerate} \
				-video_size "$((w))x$((h))" \
				-i "+$((x+bw)),$((y+bw))" \
				-f pulse \
				-i "${PaDevOut}" \
				-ac 2 \
				-vcodec libx264 \
				-acodec ${audioCodec} \
				-pix_fmt yuv420p \
				-loglevel quiet -stats \
				"${Directory}/${BaseName}-${Name}.${extention}"
		;;
		*)
		ffmpeg -y -f x11grab -r ${framerate} \
				-video_size "$((w))x$((h))" \
				-i "+$((x+bw)),$((y+bw))" \
				-vcodec libx264 \
				-pix_fmt yuv420p \
				-loglevel quiet -stats \
				"${Directory}/${BaseName}-${Name}.${extention}"
		;;
	esac
	}
}
# }}}
# active window {{{
record_act_window () {
	if [ ! -d "${Directory}" ]; then
		mkdir -p "${Directory}"
	fi
	
	DemRes=$(xwininfo -id $(xdotool getactivewindow))
	OutRes=$(xdpyinfo | grep dimensions | awk '{print $2;}')
	PaDevOut=$(pactl list short sources | awk '{print $2;}' | grep output)
	PaDevIn=$(pactl list short sources | awk '{print $2;}' | grep input)
	
	xwininfo -id $(xdotool getactivewindow) | {
	while IFS=: read -r k v; do
		case "$k" in
		*"Absolute upper-left X"*) x=$v;;
		*"Absolute upper-left Y"*) y=$v;;
		*"Border width"*) bw=$v ;;
		*"Width"*) w=$v;;
		*"Height"*) h=$v;;
		esac
	done
###
	case ${WithAudio} in
		mic)
		ffmpeg -y -f x11grab -r ${framerate} \
				-video_size "$((w))x$((h))" \
				-i "+$((x+bw)),$((y+bw))" \
				-f pulse \
				-ac 2 \
				-i default \
				-vcodec libx264 \
				-acodec ${audioCodec} \
				-pix_fmt yuv420p \
				-loglevel quiet -stats \
				"${Directory}/${BaseName}-${Name}.${extention}"
		;;
		sys)
		ffmpeg -y -f x11grab -r ${framerate} \
				-video_size "$((w))x$((h))" \
				-i "+$((x+bw)),$((y+bw))" \
				-f pulse \
				-i "${PaDevOut}" \
				-ac 2 \
				-vcodec libx264 \
				-acodec ${audioCodec} \
				-pix_fmt yuv420p \
				-loglevel quiet -stats \
				"${Directory}/${BaseName}-${Name}.${extention}"
		;;
		*)
		ffmpeg -y -f x11grab -r ${framerate} \
				-video_size "$((w))x$((h))" \
				-i "+$((x+bw)),$((y+bw))" \
				-vcodec libx264 \
				-pix_fmt yuv420p \
				-loglevel quiet -stats \
				"${Directory}/${BaseName}-${Name}.${extention}"
		;;
	esac
	}
}
# }}}
# whole screen {{{
record_screen () {
	if [ ! -d "${Directory}" ]; then
		mkdir -p "${Directory}"
	fi

	DemRes=$(xdpyinfo | grep dimensions | awk '{print $2;}')

	case ${WithAudio} in
	mic)
		ffmpeg \
			-f x11grab \
			-s "${DemRes}" \
			-i :0.0 \
			-f pulse \
			-ac 2 \
			-i default \
			-vcodec libx264 \
			-acodec ${audioCodec} \
			-r ${framerate} \
			-pix_fmt yuv420p \
			-loglevel quiet -stats \
			"${Directory}/${BaseName}-${Name}.${extention}"
		;;
	sys)
		PaDevOut=$(pactl list short sources \
			| awk '{print $2;}' \
			| grep output)
		ffmpeg \
			-f x11grab \
			-s "${DemRes}" \
			-i :0.0 \
			-f pulse \
			-i "${PaDevOut}" \
			-ac 2 \
			-vcodec libx264 \
			-acodec ${audioCodec} \
			-r ${framerate} \
			-pix_fmt yuv420p \
			-loglevel quiet -stats \
			"${Directory}/${BaseName}-${Name}.${extention}"
		;;
	none)
		ffmpeg \
			-f x11grab \
			-s "${DemRes}" \
			-i :0.0 \
			-vcodec libx264 \
			-r ${framerate} \
			-pix_fmt yuv420p \
			-loglevel quiet -stats \
			"${Directory}/${BaseName}-${Name}.${extention}"
		;;
	esac
}
# }}}
# Help {{{
help () {
	printf '%s\n' "$0" "Record screen/window" \
		"   using ffmpeg" \
	| $dmenu -p 'Help'
}
# }}}

# main {{{
choice=$(printf '%s\n' \
	"Whole screen" \
	"Active window" \
	"Select window" \
	"Help" \
	"Stop" \
	| ${dmenu} -p "${script_name}" | awk '{print $1;}')

case ${choice} in
	[sS]elect|[wW]hole|[aA]ctive)
		WithAudio=$(printf '%s\n' "none" "mic" "sys" \
			| ${dmenu} -p 'Audio?')
		BaseName=$(printf '%s' "" \
			| ${dmenu} -p 'Output name:')

		if [ -z "${BaseName}" ]; then
			BaseName="record"
		fi
	;;
esac

case ${choice} in
	[sS]elect) record_sel_window
	;;
	[aA]ctive) record_act_window
	;;
	[wW]hole) record_screen
	;;
	[sS]top) stop_record
	;;
	[hH]elp) help
	;;
	*)
		notify "Record canceled" 1
	;;
esac
# }}}
