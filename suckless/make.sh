#!/bin/sh

case $1 in
	clean)
		for i in $(find . -maxdepth 1 -type d \
			| grep -v '9base\|patch' \
			| sed -e 's/^\.//' -e 's/^\///')
		do
			cd $i
			echo "[${i}:]--------------------------------"
			make clean
			cd ..
		done
	;;
	make)
		for i in $(find . -maxdepth 1 -type d \
			| grep -v '9base\|patch' \
			| sed -e 's/^\.//' -e 's/^\///')
		do
			cd $i
			echo "[${i}:]--------------------------------"
			make
			cd ..
		done
	;;
	install)
		for i in $(find . -maxdepth 1 -type d \
			| grep -v '9base\|patch' \
			| sed -e 's/^\.//' -e 's/^\///')
		do
			cd $i
			echo "[${i}:]--------------------------------"
			sudo make install
			cd ..
		done
	;;
	help)
cat << EOF
$0
	clean       
	make       
	install     
	<no-arg>  →  make and install
EOF
	;;
	*)
		for i in $(find . -maxdepth 1 -type d \
			| grep -v '9base\|patch' \
			| sed -e 's/^\.//' -e 's/^\///')
		do
			cd $i
			echo "[${i}:]--------------------------------"
			make clean
			make
			sudo make install
			make clean
			cd ..
		done
	;;
esac

