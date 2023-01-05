#!/bin/bash
#  _  _ ___
# | || | __|	H
# | __ | _|		A
# |_||_|___|	P
#

# Variables {{{
#patched='-c -bw 2'
dmenu="dmenu \
		-i \
		-l 35 \
		${patched} \
		${@} \
		"
script_name=$(echo $0 | awk -F '/' '{print $NF;}')
#script_name="(Un)Mount/Eject"
# }}}
# send notification {{{
function notify() {
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

	notify-send  \
		-a ${script_name}  \
		-u $mode  \
		"${1}"  \
		-i xfce-mount
}
# }}}

# check status {{{
function stat_check() {
	if [ -z "${1}" ]; then
		exit 0
	fi
}
# }}}
# list {{{
function list() {
	lsblk -o NAME,FSTYPE,LABEL,SIZE,FSSIZE,FSAVAIL,FSUSE%,MOUNTPOINT --ascii \
		| sed 's/-/- /' \
		| sed 's/[|`]//g'
		#| $dmenu -p 'List:' > /dev/null
}
# }}}
# help {{{
function help() {
	if [[ $1 == 'g' ]]; then
		printf '%s\n' \
			"dmenu usb-device management script" \
			"" \
			"Usage: dm-usb.sh [muel]" \
			"" \
			"No args: Interactive menu" \
			"" \
			"m:     Mount device" \
			"u:     Unmount device" \
			"e:     Eject device" \
			"l:     List of devices" \
			"h:     Help" \
			| $dmenu -p "Help:" > /dev/null
	elif [[ $1 == 'c' ]]; then
		printf '%s\n' \
			"dmenu usb-device management script" \
			"" \
			"Usage: dm-usb.sh [muel]" \
			"" \
			"No args: Interactive menu" \
			"" \
			"m:     Mount device" \
			"u:     Unmount device" \
			"e:     Eject device" \
			"l:     List of devices" \
			"h:     Help"
	fi
}
# }}}
# mount {{{
lsblk_output=NAME,FSTYPE,SIZE,LABEL,MOUNTPOINTS
function mount() {
	device=$( {
		lsblk -lm -o ${lsblk_output} -M \
			| head -1
		lsblk -lm -o ${lsblk_output} -M \
			| grep -E '[0-9]' \
			| grep -v '/\|nvme... \|sd. '
		} \
		| $dmenu \
			-p "Mount:" )

	stat_check "${device}"

	for i in $(printf '%s\n' "${device}" | awk '{print $1};')
	do
		mounted=$(udisksctl mount -b "/dev/${i}") && notify "$mounted" || notify "Operation failed"
	done
}
# }}}
# unmount {{{
function unmount() {
	device=$( {
		lsblk -lm -o ${lsblk_output} -M \
			| head -1
		lsblk -lmn -o ${lsblk_output} -M \
			| grep -E '[0-9]' \
			| grep '/'
		} \
		| $dmenu \
			-p "Unmount:" )

	stat_check "${device}"

	for i in $(printf '%s\n' "${device}" | awk '{print $1};')
	do
		unmounted=$(udisksctl unmount -b "/dev/${i}") && notify "$unmounted" || notify "Operation failed" 3
	done
}
# }}}
# eject {{{
function pwr_off() {
	device=$( {
		lsblk -lm -o ${lsblk_output} -M \
			| head -1
		lsblk -lmn -o ${lsblk_output} -M \
			| grep 'nvme..[1-9] \|sd[a-z] ' \
			| grep -E -v '[0-9]$\|/\|nvme..[1-9]\|sd.[1-9]'
		} \
		| $dmenu \
			-p "Eject:" \
			| awk '{print $1;}')

	for i in $(printf '%s\n' ${device})
	do
		power_offed=$(udisksctl power-off -b "/dev/${i}")
		notify "Device ${i} Ejected"
			#|| notify "Operation failed"
	done
}
# }}}
# interactive {{{
function interactive() {
	i=$( {
			printf '%s\n' \
				"Help" "Mount" "Unmount" "Eject"
			printf '%s' \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----" \
				"-----"
			echo

			list
		} | $dmenu -p ${script_name})

	stat_check "$i"

	case $i in
		Mount) mount ;;
		Unmount) unmount ;;
		Eject) pwr_off ;;
		Help) help g ;;
		*) exit 1 ;;
	esac
}
# }}}

case $1 in
	m) mount ;;
	u) unmount ;;
	e) pwr_off ;;
	h) help c ;;
	*) interactive ;;
esac
