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

if [ ! $# = 5 ]; then
	printf '%s\n' '$1 -> input' '$2 -> input color' \
		'$3 -> output color' '$4 -> percentage' '$5 -> [optional] output (empty will write on input)'
	#'$2 -> output' 
else
	cp -f $1 $1.bak && printf '%b\t' \
		"${YLW}${i}${RST}" \
		"${BLU}(backed-up)${RST}"

	if [ -z $5 ]; then
		outname=$1
	else
		outname=$5
	fi

	convert $1 -fuzz $4% -fill $3 -opaque $2 ${outname}

	if [ "$?" -eq '0' ]; then
		echo -e "${GRN}[done]${RST}"
	else
		echo -e "${RED}[error]${RST}"
	fi
fi
