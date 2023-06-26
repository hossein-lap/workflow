#!/bin/sh

dmenu_path | dmenu "$@" |
    while read -r cmd; do
        echo "$cmd" | xargs setsid -f # TODO: make it simpler (just `setsid -f "$cmd"` doesn't work in all cases)
    done
