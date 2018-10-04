#!/bin/sh
# attach to hidpi monitor and turn off the laptop monitor.
# eventually turn into something more dynamic
xrandr --output DP-1 --auto --scale 2x2 --right-of DP-4 && xrandr --output DP-4 --auto --off
