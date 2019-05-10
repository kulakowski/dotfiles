#!/bin/bash

PATH=/home/gk/bin:$PATH

xrdb ~/.Xresources
xmodmap .Xmodmap
xsetroot -cursor_name left_ptr

xscreensaver &

stalonetray --window-layer top --window-type normal --window-strut none --geometry 1x1+900+1170 &
nm-applet &
pasystray &

exec /home/gk/bin/xmonad
