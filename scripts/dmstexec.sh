#!/bin/sh

c='•'

tmp() {
cat << EOF
${SHELL}
xbps-query -Rs 
sudo sv restart 
iwctl station list 
pulsemixer
btop
EOF
}

term=st
sh="bash"
runner="dmenu -p exec -l 5"
thecommand=$(tmp | sed "s/^/${c} /" | $runner | sed "s/^${c} //")

$term -t Terminal $sh -c "echo "${thecommand}"; ${thecommand}; $sh"
