#!/bin/bash

mplayer \
    tv:// \
    -tv driver=v4l2:device=/dev/video0:width=480:height=360:fps=30:outfmt=yuy2 
#    -benchmark \
#    1>/dev/null 2>/dev/null
