#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#              

#!/bin/sh

case $1 in
s)
	printf 'nameserver %s\n' \
		"178.22.122.100" "185.51.200.2" \
		| sudo tee /etc/resolv.conf
	;;
*)
	printf 'nameserver %s\n' \
		"4.2.2.4" \
		| sudo tee /etc/resolv.conf
	;;
esac
