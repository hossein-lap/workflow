#!/bin/sh

# Variables {{{
path="$HOME/.local/dev/hossein-lap/workflow/scripts"

patched='-c -bw 2 -g 1 -l 8'
dmenu="dmenu \
		-i \
		${patched} \
		${@} \
		"
script_name=$(echo $0 | awk -F '/' '{print $NF;}')
#script_name="ScriptRunner"
# }}}

script=$(printf '%s\n' \
	"$(ls ${path}/*.sh)" \
	| awk -F '/' '{print $NF;}' \
	| $dmenu -p "${script_name}")

sh ${path}/$script "${@}"
