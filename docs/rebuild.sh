#!/bin/sh

list=$(find . -maxdepth 1 -type d | grep -v 'theme\|\.$\|filters' | sed 's,^\./,,' | grep -v '.\..')

for i in ${list}; do
	echo "≡≡≡≡≡≡≡≡ ${i} ≡≡≡≡≡≡≡≡"
	cd ${i}
	make full
	echo "======================"
	cd ..
done
