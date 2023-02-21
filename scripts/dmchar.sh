#!/bin/sh

prompt=$(echo $0 | awk -F '/' '{print $NF;}')
patched='-c -bw 2 -g 2 -l 2'
runner="dmenu -l 9 -p ${prompt} ${patched}"
path="$HOME/.local/chars/"

list=$(printf '%s\n' "unicode" "nerdfont" "font-awesome" "*" | $runner) \
	&& chosen=$(cut -d ';' -f1 ${path}/${list}.txt | ${runner}) \
	&& notify-send -a ${prompt} "Copied to clipboard" "${chosen}" \
	&& printf ${chosen} | sed "s/ .*//" \
		| xclip -selection clipboard

