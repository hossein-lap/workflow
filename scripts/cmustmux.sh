#!/bin/bash
#  _  _
# | || |
# | __ |
# |_||_|
#

player="cmus"
term="st -t Terminal"

if [[ -z $(tmux ls | grep '^Music') ]]; then
	$term -e tmux new -s Music $player
else
	$term -e tmux att -t Music
fi
