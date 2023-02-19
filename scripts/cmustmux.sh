#!/bin/sh

player="cmus"
term="st -t Terminal"

if [ -z $(tmux ls | grep '^Music') ]; then
	$term -e tmux new -s Music $player
else
	$term -e tmux att -t Music
fi
