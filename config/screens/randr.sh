#!/bin/sh

ResX="1920"
ResY="1080"
Res="${ResX}x${ResY}"

xrandr \
	--output eDP-1 \
		--primary --mode ${Res} --pos 0x${ResY} --rotate normal \
	--output HDMI-1 \
		--mode ${Res} --pos 0x0 --rotate normal \
	--output DP-1 --off \
	--output HDMI-2 --off \
	--output DP-1-0 --off \
	--output DP-1-1 --off \
	--output DP-1-2 --off \
	--output DP-1-3 --off

#	--output eDP-1 --primary --mode ${Res} --pos 0x1080 --rotate normal \
#	--output HDMI-1 --mode ${Res} --pos 0x0 --rotate normal \
#	--output DP-1 --off \
#	--output HDMI-2 --off \
#	--output DP-1-0 --off \
#	--output DP-1-1 --off \
#	--output DP-1-2 --off \
#	--output DP-1-3 --off

notify-send -a xrandr "resolution is set ${Res}"
sleep 1

xwallpaper --no-randr --zoom ~/pic/.wall
notify-send -a xwallpaper "background is set"
