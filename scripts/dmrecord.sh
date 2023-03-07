#!/bin/sh
#  _  _
# | || |
# | __ |
# |_||_|
#
set -e

# Variables {{{
#patched='-c -bw 4 -g 1'
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

	DemRes=$(xdotool selectwindow getwindowgeometry --shell | awk -F '=' '{print $NF;}')
	OutRes=$(xdpyinfo | grep dimensions | awk '{print $2;}')
	PaDevOut=$(pactl list short sources | awk '{print $2;}' | grep output)

	xwininfo | {
	while IFS=: read -r k v; do
		case "$k" in
		*"Absolute upper-left X"*) x=$v;;
		*"Absolute upper-left Y"*) y=$v;;
		*"Border width"*) bw=$v ;;
		*"Width"*) w=$v;;
		*"Height"*) h=$v;;
		esac
	done

	ffmpeg -y -f x11grab -framerate 30 \
			-video_size "$((w))x$((h))" \
			-i "+$((x+bw)),$((y+bw))" \
			-f pulse -ac 2 \
			-i "${PaDevOut}" \
			-vcodec libx264 \
			-acodec ${audioCodec} \
			-r 30 \
			-pix_fmt yuv420p \
			-loglevel quiet -stats \
			"${Directory}/${BaseName}-${Name}.${extention}"
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
	case $WithAudio in
		mic)
		ffmpeg -y -f x11grab -framerate 30 \
				-video_size "$((w))x$((h))" \
				-i "+$((x+bw)),$((y+bw))" \
				-f pulse \
				-ac 2 \
				-i default \
				-vcodec libx264 \
				-acodec ${audioCodec} \
				-pix_fmt yuv420p \
				"${Directory}/${BaseName}-${Name}.${extention}"
				#-loglevel quiet -stats \
		;;
		sys)
		ffmpeg -y -f x11grab -framerate 30 \
				-video_size "$((w))x$((h))" \
				-f pulse \
				-i "${PaDevOut}" \
				-ac 2 \
				-vcodec libx264 \
				-acodec ${audioCodec} \
				-pix_fmt yuv420p \
				"${Directory}/${BaseName}-${Name}.${extention}"
				#-loglevel quiet -stats \
		;;
		*)
		ffmpeg -y -f x11grab -framerate 30 \
				-video_size "$((w))x$((h))" \
				-i "+$((x+bw)),$((y+bw))" \
				-vcodec libx264 \
				-pix_fmt yuv420p \
				"${Directory}/${BaseName}-${Name}.${extention}"
				#-loglevel quiet -stats \
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

	if [ $WithAudio = 'mic' ]; then
		ffmpeg \
			-f x11grab \
			-s "${DemRes}" \
			-i :0.0 \
			-f pulse \
			-ac 2 \
			-i default \
			-vcodec libx264 \
			-acodec ${audioCodec} \
			-r 30 \
			-pix_fmt yuv420p \
			-loglevel quiet -stats \
			"${Directory}/${BaseName}-${Name}.${extention}"

	elif [ $WithAudio = 'sys' ]; then
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
			-r 30 \
			-pix_fmt yuv420p \
			-loglevel quiet -stats \
			"${Directory}/${BaseName}-${Name}.${extention}"
	else
		ffmpeg \
			-f x11grab \
			-s "${DemRes}" \
			-i :0.0 \
			-vcodec libx264 \
			-r 30 \
			-pix_fmt yuv420p \
			-loglevel quiet -stats \
			"${Directory}/${BaseName}-${Name}.${extention}"
	fi
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
	| $dmenu -p "${script_name}" | awk '{print $1;}')

case $choice in
	Select|Whole|Active)
		WithAudio=$(printf '%s\n' "none" "mic" "sys" \
			| $dmenu -p 'Audio?')
		BaseName=$(printf '%s' "" \
			| $dmenu -p 'Output name:')

		if [ -z "${BaseName}" ]; then
			BaseName="record"
		fi
	;;
esac

case $choice in
	Select) record_sel_window
	;;
	Active) record_act_window
	;;
	Whole) record_screen
	;;
	Stop) stop_record
	;;
	Help) help
	;;
	*)
		notify "Record canceled" 1
	;;
esac
# }}}
