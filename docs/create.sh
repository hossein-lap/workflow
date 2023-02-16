#!/bin/bash
#  _  _
# | || | github: hossein-lap
# | __ | email:  hosteam01@gmail.com
# |_||_| matrix: hosaidenpwd:matrix.org
#

#for i in $(exa -D | grep -v 'theme')
#do
	#j=$(echo $i | sed -e 's/\b\(.\)/\u\1/')
#
	#if [[ ! -f "$i/$i.md" ]]; then
		#echo "# $j Cheatsheet" # > $i/$i.md
	#fi
#
	#if [[ ! -f "$i/Makefile" ]]; then
		#echo "$i/Makefile"
		#cp -v lua/Makefile $i/
		##sed -i "s/Lua/$j/" $i/Makefile
		##sed -i "s/lua/$i/" $i/Makefile
	#fi
#done

if [[ ! -d "$1" ]]; then
	mkdir -v "$1"
else
	echo 'Directory exists!'
fi

if [[ ! -f "$1/Makefile" ]]; then
	echo -n 'cp: copied file '
	cp -v lua/Makefile "$1/Makefile"
	j=$(echo $1 | sed -e 's/\b\(.\)/\u\1/')
	sed -i "s/Lua/$j/" $1/Makefile
	sed -i "s/lua/$1/" $1/Makefile
	echo "# $j" > $1/$1.md
	cd $1
	echo -n 'ln: linked file '
	ln -vs $1.md README.md
	cd ..
else
	echo 'And it contains files!'
fi
