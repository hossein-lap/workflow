#!/bin/sh

defpicdir="${HOME}/pic"
script_name=$(echo ${0} | awk -F '/' '{print $NF;}')

help() {
cat << EOF
usage: ${script_name} [img] [dir] [-s <dir>] [-h] []
	-h             print this message
	-s <dir>       random pic from <dir> as wallpaper
	<img>          set the image as wallpaper
	<dir>          set a random picture as wallpaper
	<no args>      choose a picture from "${defpicdir}"
EOF
}

notif_send() {
	if [ ${?} -eq 0 ]; then
		notify-send -u normal -a ${script_name} -i background "${1}" "${2}"
	fi
}

shuf_wall() {
	thewall=$(ls ${1}/*.{jpg,png} | shuf | head -1)
	xwallpaper --zoom ${thewall}
	cp -f ${thewall} ${defpicdir}/.wall
	ww="$(echo ${thewall} | awk -F '/' '{print $NF;}')"
	if [ $? -eq 0 ]; then
		notif_send "Wallpaper changed" "${ww}"
		exit 0
	else
		exit 1
	fi
}

dir_wall() {
	thewall=$(nsxiv -or "${1}")
	if [ -f "${thewall}" ]; then
		xwallpaper --zoom ${thewall}
		cp -f ${thewall} ${defpicdir}/.wall
		ww="$(echo ${thewall} | awk -F '/' '{print $NF;}')"
		if [ $? -eq 0 ]; then
			notif_send "Wallpaper changed" "${ww}"
			exit 0
		else
			exit 1
		fi
	fi
}

set_wall() {
	ww="$(echo ${1} | awk -F '/' '{print $NF;}')"
	if [ -n "${ww}" ]; then
		xwallpaper --zoom ${1}
		cp -f ${1} ${defpicdir}/.wall
		notif_send "Wallpaper changed" "${ww}"
		exit 0
	else
		exit 1
	fi
}

choose_wall() {
	wall="$(nsxiv -ro ~/pic/wall)"
	set_wall ${wall}
}

if [ "${1}" = '-h' ]; then
	help
	exit 0
elif [ "${1}" = '-s' ]; then
	shuf_wall ${2}
elif [ -d "${1}" ]; then
	dir_wall ${1}
elif [ -f "${1}" ]; then
	set_wall ${1}
else
	choose_wall
fi
