#!/bin/sh

RST='\e[0m'
BLD='\033[1m'
YLW='\e[33m'
BLU='\e[34m'
GRN='\e[32m'
RED='\e[31m'

shadow_border_ts () {
	if [ -z "$1" ]; then
		printf '%s\n' "No image name or argument is specified :/"
		exit 1
	fi

	$(which convert) \
		$1 \
		-bordercolor none \
		-border 10 \
		\( +clone -background \
		black -shadow 110x10+5+5 \) \
		+swap -background none \
		-layers merge +repage \
		$1
}

for i in "$@"
do
#	cp -f $1 $1.bak \
#	&& printf '%b\t' \
#		"${YLW}${i}${RST}" \
#		"${BLU}(backed-up)${RST}"
#
	printf '%b\t' \
		"${YLW}${i}${RST}"

	shadow_border_ts "$i"

	if [ "$?" -eq '0' ]; then
		echo -e "${GRN}[done]${RST}"
	else
		echo -e "${RED}[error]${RST}"
	fi
done
