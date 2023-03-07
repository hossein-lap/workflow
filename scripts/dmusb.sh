#!/bin/sh
#  _  _ ___
# | || | __|	H
# | __ | _|		A
# |_||_|___|	P
#

# Variables {{{
#patched='-c -bw 4'
dmenu="dmenu \
		-i \
		-l 35 \
		${patched} \
		${@} \
		"
script_name=$(echo $0 | awk -F '/' '{print $NF;}')
#script_name="(Un)Mount/Eject"
sep="---------------------------------------------------------------------------"
# }}}
# send notification {{{
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

	notify-send  \
		-a ${script_name}  \
		-u $mode  \
		"${1}"  \
		-i xfce-mount
}
# }}}

# check status {{{
stat_check() {
	if [ -z "${1}" ]; then
		exit 0
	fi
	if [ "${1}" = "${sep}" ]; then
		exit 0
	fi
	if [ "${1}" = "NAME" ]; then
		exit 0
	fi
}
# }}}
# list {{{
list() {
	lsblk -o NAME,FSTYPE,LABEL,SIZE,FSSIZE,FSAVAIL,FSUSE%,MOUNTPOINT --ascii \
		| sed -e 's/-/ /' \
			-e 's/[|`]/•/g'
		#| $dmenu -p 'List:' > /dev/null
}
# }}}
# help {{{
help() {
	if [ -z ${DISPLAY} ]; then
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
	else
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
	fi
}
# }}}
# mount {{{
lsblk_output=NAME,FSTYPE,SIZE,LABEL,MOUNTPOINTS
mount() {
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
		mounted=$(udisksctl mount -b "/dev/${i}") \
			&& notify "$mounted" \
			|| notify "Operation failed"
	done
}
# }}}
# unmount {{{
unmount() {
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
		unmounted=$(udisksctl unmount -b "/dev/${i}") \
			&& notify "$unmounted" \
			|| notify "Operation failed" 3
	done
}
# }}}
# eject {{{
pwr_off() {
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
		power_offed=$(udisksctl power-off -b "/dev/${i}") \
			&& notify "${power_offed}" \
			|| notify "Operation failed"
	done
}
# }}}
# onair {{{
onair() {
	z=$(echo ${1} | grep '^•' | awk '{print $NF;}' | grep '^[0-9]')
	w=$(echo ${1} | awk '{print $NF;}' | grep '^[0-9]')
	if [ -z "${w}" ]; then
		airdo=unmount
	else
		if [ -z ${z} ]; then
			airdo=eject
		else
			airdo=mount
		fi
	fi
	
	x=$(echo ${1} | sed 's/^• //' | awk '{print $1;}')
	doublecheck=$(printf 'no\nyes' | ${dmenu} -l 1 -g 2 -p "(${airdo} ${x}) you sure?")

	case ${doublecheck} in
		yes)
			case ${airdo} in
				eject)
					power_offed=$(udisksctl power-off -b "/dev/${x}") \
						&& notify "/dev/${x} ejected" \
						|| notify "Operation failed" 3
					;;
				mount)
					mounted=$(udisksctl mount -b "/dev/${x}") \
						&& notify "$mounted" \
						|| notify "Operation failed" 3
					;;
				unmount)
					unmounted=$(udisksctl unmount -b "/dev/${x}") \
						&& notify "$unmounted" \
						|| notify "Operation failed" 3
					;;
			esac
			;;
		no)
			interactive
			;;
		*)
			exit 5
			;;
	esac
}
# }}}
# interactive {{{
interactive() {
	i=$( {
			printf '%s\n' \
				"Help" "Mount" "Unmount" "Eject"
			printf '%s\n' "${sep}"
			list
		} | $dmenu -p ${script_name})

	stat_check "$i"

	case $i in
		[Mm]ount) mount ;;
		[Uu]nmount) unmount ;;
		[Ee]ject) pwr_off ;;
		[Hh]elp) help g ;;
		*) onair "${i}" ;;
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
