#!/bin/sh

printf '%s %s %s' \
	$(jdate '+%m/%d') \
	$(date '+%y/%m/%d %H:%M')
