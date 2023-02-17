#!/bin/sh

printf 'm:%sM h:%s' \
	$(free -m | grep '^Mem' | awk '{print $3 + $5;}') \
	$(df -h /home | awk '{print $4;}' | tail -n 1)
