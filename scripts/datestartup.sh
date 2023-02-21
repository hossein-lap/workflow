#!/bin/bash

echo
{
	echo '╭──────────────────────╮'
	printf '│    \e[33m%s\e[0m, \e[32m%s\e[0m     │\n' \
		`jdate '+%h'` \
		`jdate '+%H:%M:%S'`
	echo '│──────────────────────│'
	jcal -P \
		| head -n 7 \
		| sed 's/^/│ /' \
		| sed 's/$/ │/'
	echo '╰──────────────────────╯'
} | sed 's/^/  /'
echo -n '  '
printf ' \e[30m● '
printf ' \e[31m● '
printf ' \e[32m● '
printf ' \e[33m● '
printf ' \e[34m● '
printf ' \e[35m● '
printf ' \e[36m● '
printf ' \e[37m● '
printf '\e[0m\n'
echo 
#echo -n '  '
#printf '\e[40m   '
#printf '\e[41m   '
#printf '\e[42m   '
#printf '\e[43m   '
#printf '\e[44m   '
#printf '\e[45m   '
#printf '\e[46m   '
#printf '\e[47m   '
#printf '\e[0m\n\n'
