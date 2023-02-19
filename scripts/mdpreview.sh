#!/bin/sh

ps aux | grep "st lynx ${1}" | grep -v 'grep st lynx'
