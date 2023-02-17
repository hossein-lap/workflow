#!/bin/sh

# dmenu prompt
prompt=$(echo $0 | awk -F '/' '{print $NF;}')

# runner, dmenu or fzf {{{
if [ "$1" = '-c' ] || [ -z ${DISPLAY} ]; then
	runner="fzf \
			-i \
			-m \
			--reverse \
			--border --border-label=${prompt} \
			--info=inline \
			--prompt=: \
			"
else
	runner="dmenu \
			-i \
			-l 5 \
			-p ${prompt} \
			"
fi
# }}}
# notify {{{
notify() {
	case $3 in
		1) urg="low" ;;
		2) urg="normal" ;;
		3) urg="critical" ;;
		*) urg="normal" ;;
	esac
	notify-send -a ${prompt} -i qemu -u ${urg} "$1" "$2"
}
# }}}

# qemu binary {{{
bin="qemu-system-x86_64"
check_path=$(whereis ${bin} | awk -F ':' '{print $2;}')
if [ -z ${check_path} ]; then
	echo "No executable found!" > /dev/stderr
	echo "Please install qemu" > /dev/stderr
	notify "No executable found!" "Please install “qemu”"
	exit 1
else
	bin_path=$(which ${bin})
fi
# }}}
# base directory {{{
path="${HOME}/.local/virtual-machines/kvm"
	[ ! -d ${path} ] && mkdir -p ${path}
# }}}
# choose the virtual-machine {{{
vm_name=$(ls -l ${path} \
		| grep '^d' \
		| ${runner} \
		| awk '{print $NF;}')
	[ -z ${vm_name} ] && exit 2
# }}}
# vm's directory {{{
name=$(printf ${path}/${vm_name})
shared_folder="${name}/share"
image_path="${name}/${vm_name}.qcow2"
# }}}
# ssh variables {{{
vm_username=hos
vm_ipaddr=localhost
if [ -f "${name}/port" ]; then
	port_number=$(cat ${name}/port)
else
	notify "${vm_name}" "Does not have a “port” file"
	exit 4
fi
#	port_number=$(printf "${ssh_pid}%.0s" {1..4})
# }}}
# paths {{{
img_path="${path}/debian/debian.qcow2"
shrd_fold_path="${path}/debian/share"
# }}}
# PIDs {{{
ssh_pid=$(ps a -o pid,cmd \
    | grep ssh \
    | grep -c "\-p ${port_number}")

qemu_pid=$(ps a -o pid,cmd \
    | grep ${vm_name} \
    | grep ${bin_path} \
    | awk '{print $1;}')
# }}}

## some qemu argumets {{{
#	-daemonize
#	-nographics
#	-serial stdio
#	-net nic -net user,smb=/home/hos/Public/share/arch
#	-net user,hostfwd=tcp::7777-:8001
#	-cdrom /home/prime/dl/iso/manjaro-i3-21.1.2-minimal-210907-linux513.iso
#	-redir tcp:2222::22
#	-device usb-kbd
#	-device usb-mouse
#	-clock unix
## }}}

# functions {{{

# run {{{
run () {
if [ -z ${qemu_pid} ]; then
	nohup \
	${bin_path} \
		-boot order=d \
		-drive file=${image_path},format=qcow2 \
		-m 1024 \
		-smp 1 \
		-nographic \
		-enable-kvm \
		-net nic,model=virtio \
		-net user,hostfwd=tcp::${port_number}-:22,smb=${shared_folder} \
		& 2>&1 > /dev/null
	notify "${vm_name}" "Starting..."
	else
		printf '\n%s\n' "${vm_name} is already running"
		printf '%s\n' "PID: ${qemu_pid}"
		notify "${vm_name} is already running" "PID: ${qemu_pid}"
	fi
}
# }}}

# poweroff {{{
pwroff () {
	printf '%s\n' "[sudo shutdown -h now]"
	if [ ! -z ${qemu_pid} ]; then
		ssh ${vm_username}@${vm_ipaddr} -p ${port_number} -t "sudo shutdown -h now"
		notify "${vm_name}" "Shutting down.."
	else
		printf '\n%s\n' "${vm_name} is powered off"
		notify "${vm_name}" "${vm_name} is powered off"
	fi
}
# }}}
# connect [ssh] {{{
connect () {
	ssh ${vm_username}@${vm_ipaddr} -p ${port_number}
}
# }}}
# help {{{
help () {
cat << EOF
on/r:   Run the virtual machine
ssh/c:  Connect to the machine via ssh
off:    Poweroff the machine
EOF
	if [ ! -z ${qemu_pid} ]; then
		for i in ${qemu_pid}; do
			printf '\n%s\n' "${i} → PID: ${qemu_pid}"
			notify "${vm_name}" ""
			if [ ! -z ${ssh_pid} ]; then
				printf '%s\n' "${ssh_pid} ssh session(s)"
				notify "${vm_name}" ""
			else
				printf '%s\n' "No ssh session"
				notify "${vm_name}" ""
			fi
		done
	else
		printf '\n%s\n' "${vm_name} powered off"
		notify "${vm_name}" "powered off"
	fi
}
# }}}
## status {{{
#vm_status() {
#	
#}
## }}}
# intractive {{{
intractive() {
	dmenu_choice=$(printf '%s\n' \
		'run' 'connect' 'poweroff' 'help' 'status' \
		| ${runner})

	case ${dmenu_choice} in
		run)		run ;;
		connect)	connect ;;
		poweroff)	pwroff ;;
		status)		stat ;;
		help)		help | ${runner} ;;
	esac
}
# }}}

# }}}

case $1 in
	r|on)		run ;;
	ssh|c)		connect ;;
	off)		pwroff ;;
	status)		vm_status ;;
	help)		help ;;
	*)			intractive ;;
esac
