#!/bin/sh
#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#              
set -e
RST='\e[0m'
BLD='\033[1m'
YLW='\e[33m'
BLU='\e[34m'
GRN='\e[32m'
RED='\e[31m'

for i in "$@"
do
	cp -f $1 $1.bak && printf '%b\t' \
		"${YLW}${i}${RST}" \
		"${BLU}(backed-up)${RST}"

	convert $i -channel RGB -negate $i

	if [ "$?" -eq '0' ]; then
		echo -e "${GRN}[done]${RST}"
	else
		echo -e "${RED}[error]${RST}"
	fi
done
