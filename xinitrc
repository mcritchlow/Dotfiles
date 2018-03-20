#!/bin/sh
#
# load DISPLAY and XAUTHORITY into systemd
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset -b # disable bell
setxkbmap -model thinkpad -layout us -option caps:swapescape

# autostart
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/redshift-gtk &
dropbox start &
/usr/local/bin/slstatus &

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec dwm 2> /tmp/dwm.log
