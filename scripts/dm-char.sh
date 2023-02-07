#!/bin/sh

prompt=$(echo $0 | awk -F '/' '{print $NF;}')
patched='-c -bw 2 -g 1 -l 18'
runner="dmenu -l 9 -p ${prompt} ${patched}"
path="$HOME/.local/chars/"

list=$(printf '%s\n' "unicode" "nerdfont" "font-awesome" | $runner -l 2 -g 2) \
	&& chosen=$(cut -d ';' -f1 ${path}/${list}.txt | ${runner}) \
	&& notify-send -a ${prompt} "Copied to clipboard" "${chosen}" \
	&& printf ${chosen} | sed "s/ .*//" \
		| xclip -selection clipboard

