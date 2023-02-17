#!/bin/dash

help() {
cat << EOF
Change wallpaper
EOF
}

notif_send() {
	script_name=$(echo $0 | awk -F '/' '{print $NF;}')
	if [ $? -eq 0 ]; then
		notify-send -u normal -a $script_name -i background "$1"
	fi
}

shuf_wall() {
	thewall=$(ls ${1}/*.{jpg,png} | shuf | head -1)
	xwallpaper --zoom "$thewall"
	cp -f "$thewall" ~/pic/.wall
	ww="$(echo "$thewall" | awk -F '/' '{print $NF;}')"
	if [ $? -eq 0 ]; then
		notif_send "Wallpaper changed: $ww"
		exit 0
	else
		exit 1
	fi
}

set_wall() {
	xwallpaper --zoom "$1"
	cp -f "$1" ~/pic/.wall
	ww="$(echo $1 | awk -F '/' '{print $NF;}')"
	if [ $? -eq 0 ]; then
		notif_send "Wallpaper changed: $ww"
		exit 0
	else
		exit 1
	fi
}

choose_wall() {
	wall="$(nsxiv -ro ~/pic/wall)"
	set_wall "$wall"
	if [ $? -eq 0 ]; then
		notif_send "Wallpaper changed: $ww"
		exit 0
	else
		exit 1
	fi
}

[ -d "$1" ] && shuf_wall $1
[ -f "$1" ] && set_wall $1

choose_wall
