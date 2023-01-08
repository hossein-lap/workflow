#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#

#!/bin/sh

xset r rate 300 50 &

#~/.fehbg &

xrdb ~/.Xresources &
xwallpaper --stretch $HOME/pictures/Resplash/zZkMki0yH6I_Full.jpg &
~/bin/xrate &
pulseaudio &
