#!/bin/sh

printf ' %s %s %s %s' \
	$(jdate '+%m%d') \
	$(date '+%a %y%m%d %H%M')
