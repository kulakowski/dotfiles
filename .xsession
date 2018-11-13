#!/bin/bash

PATH=/usr/local/google/home/kulakowski/bin:$PATH

xrdb ~/.Xresources
xmodmap .Xmodmap
xsetroot -cursor_name left_ptr

xscreensaver &

stalonetray --window-layer top --window-type normal --window-strut none --geometry 1x1+900+1170 &
nm-applet &
pasystray &

exec /usr/local/google/home/kulakowski/bin/xmonad
