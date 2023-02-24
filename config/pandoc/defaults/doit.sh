#!/bin/sh

for i in `exa -D | grep -v groff`; do
	cd ${i}
	echo "$i:"
	sed "s,pandoc/${i},pandoc/defaults/${i}," \
		*.sty *.yaml | grep defaults
	echo
	ls *.sty *.yaml
	echo '-------------------------------------------------------'
	cd ..
done
