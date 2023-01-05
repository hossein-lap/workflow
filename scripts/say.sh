#!/bin/bash

#> cowsay-list.txt
#
#for i in `cat cowsay-f.sh`; do
	#echo This is $i | cowsay -f $i
	#read -p "Liked $i? " tmpvar
	#if [[ $tmpvar == 'y' ]]; then
		#echo $i >> cowsay-list.txt
	#fi
	#clear
#done

choice=$(echo "`date +%s` % 3" | bc)

case $choice in
	0)
		opt=tux
		;;
	1)
		opt=daemon
		;;
	2)
		opt=blowfish
		;;
esac

fortune | cowsay -f $opt
