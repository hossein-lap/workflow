#!/bin/sh
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

if [ -z "$1" ]; then
cat << _EOF_
Create new repo on github.com/hossein-lap

You need to specify a name as an argument.
_EOF_
elif [ -d "$1" ]; then
	echo "The repo already exists!"
else
	mkdir "$1"
	cd "$1"

	echo "# $1" >> README.md
	git init
	git add README.md
	git commit -m "first commit"
	git branch -M main
	git remote add origin git@github.com:hossein-lap/"$1".git
	git push -u origin main
fi

