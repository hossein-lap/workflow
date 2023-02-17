#!/bin/sh

create_install() {
}

create_run() {
}

## Main
ENVIRONMENT="dev"
DB_PATH="/data/db"

usage() {
cat << EOF
$0
	-h	help mesage
	-e	some arg
	-p	some another arg

EOF
}

while [ -n "$1" ]; do
	PARAM="$(printf "%s\n" $1 | awk -F= '{print $1}')"
	VALUE="$(printf "%s\n" $1 | sed 's/^[^=]*=//g')"

	if [ $VALUE = $PARAM ]; then
		shift
		VALUE=$1
	fi

	case $PARAM in
		-h)
			usage
			exit
			;;
		-e)
			ENVIRONMENT=$VALUE
			;;
		-p)
			DB_PATH=$VALUE
			;;
		*)
			echo "ERROR: unknown parameter \"$PARAM\"" > /dev/stderr
			echo
			usage
			exit 1
			;;
	esac

	shift
done



