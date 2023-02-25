#!/bin/sh

c='•'

tmp() {
cat << EOF
${SHELL}
xbps-query -Rs 
sudo sv restart 
iwctl station list 
pulsemixer
xprop
btop
EOF
}

term=st
sh="bash"
runner="dmenu -p exec -l 5"

$term -t Terminal $sh -c "$(tmp | sed "s/^/${c} /" | $runner | sed "s/^${c} //") && $sh"
