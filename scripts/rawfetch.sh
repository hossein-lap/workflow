#!/bin/sh
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

for i in "$@"
do
	curl "$i" > "$(echo "$i" | awk -F '/' '{print $NF;}')"
done
