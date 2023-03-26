#!/bin/bash
# more info on http://joewing.net/projects/jwm/config-2.3.html
#function run {
#	if [ -z $(pgrep $1) ]; then
#		$@ &
#	else
#		pkill $1 && $@ &
#	fi
#}
#autorandr horizontal
#change your keyboard if you need it
#setxkbmap -layout be
# start ArcoLinux Welcome  App
#dex $HOME/.config/autostart/arcolinux-welcome-app.desktop

sxhkd &
#slstatus &
#xcompmgr &
#dunst &
#xwallpaper --zoom ~/pic/.wall &

#unset run

#xsetroot -cursor_name left_ptr &
#run volumeicon &
##run variety &
#run nm-applet &
##run pamac-tray &
#run xfce4-power-manager &
#numlockx on &
#blueberry-tray &

##picom --config $HOME/.config/jwm/picom.conf &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &
#nitrogen --restore &
##run caffeine &
##run vivaldi-stable &
##run firefox &
##run thunar &
##run dropbox &
##run insync start &
##run discord &
##run spotify &
##run atom &
##run conky-toggle &
#run conky -c ~/.config/conky/Arco-Redux-LUA.conkyrc &
