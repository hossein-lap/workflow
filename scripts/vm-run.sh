#!/bin/sh

# base variable definitions
bin_path=$(which qemu-system-x86_64)
storage="${HOME}/.local/virtual-machines/kvm/"
prompt=$(echo $0 | awk -F '/' '{print $NF;}')
vm_username=hos
vm_ipaddr=localhost

# function definitions
vm_run() {
	if [ -z ${qemu_pid} ]; then
		-boot order=d \
		-drive file=${img},format=qcow2 \
		-m 1024 \
		-smp 1 \
		-nographic \
		-enable-kvm \
		-net nic,model=virtio \
		-net user,hostfwd=tcp::${port_number}-:22,smb=${shared_folder} \
		& 2>&1 > /dev/null
	else
		printf '\n%s\n' "The vm is already running"
		printf '%s\n' "qemu PID: ${qemu_pid}"
	fi
}

vm_off() {
	printf '%s\n' "[sudo shutdown -h now]"
	if [ -n ${qemu_pid} ]; then
		ssh ${vm_username}@${vm_ipaddr} -p ${port_number} -t "sudo shutdown -h now"
	else
		printf '\n%s\n' "The vm is powered off"
	fi
}

vm_connect() {
	st ssh ${vm_username}@${vm_ipaddr} -p ${port_number}
}

# run dmenu or fzf
if [ "$1" = '-c' ] || [ -z $DISPLAY ]; then
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
			-p ${prompt} \
			"
fi

# create menus and extra variables
menu=$(find ${storage} -maxdepth 1 -type d \
		| awk -F '/' '{print $NF;}' \
		| grep -v '^$' \
		| $runner)
name=$(printf $storage$menu)


img="${name}/${menu}.qcow2"
shared_folder="${name}/share/"

ssh_pid=$(ps a -o pid,cmd \
    | grep -c $menu)

qemu_pid=$(ps a -o pid,cmd \
    | grep $menu \
    | grep ${bin_path} \
    | awk '{print $1;}')

# port number
case $menu in
	arch)
		port_number=1111
	;;
	debian)
		port_number=2222
	;;
	suse)
		port_number=3333
	;;
	fbsd)
		port_number=4444
	;;
	*)
		port_number=$(printf "${ssh_pid}%.0s" {1..4} )
	;;
esac

## main
#choice=$(printf '%s\n' 'run' 'gui' 'off' 'reboot' | $runner)
#case $choice in
#	run)
#	;;
#	gui)
#	;;
#	off)
#	;;
#	reboot)
#	;;
#	*)
#	;;
#esac
