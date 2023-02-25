#!/bin/sh

prompt=$(echo $0 | awk -F '/' '{print $NF;}')
patched='-bw 0 -g 3 -l 20'
runner="dmenu -l 9 -p ${prompt} ${patched}"
path="$HOME/.local/hos/chars/"

list=$(printf '%s\n' "unicode" "emoji" "nerdfont" "font-awesome" "*" | $runner) \
	&& chosen=$(cut -d ';' -f1 ${path}/${list}.txt | ${runner}) \
	&& notify-send -a ${prompt} "Copied to clipboard" "${chosen}" \
	&& printf ${chosen} | sed "s/ .*//" \
		| xclip -selection clipboard

