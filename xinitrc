#!/bin/sh
#
exec >/tmp/startx$$.log 2>&1

# load DISPLAY and XAUTHORITY into systemd
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset -b # disable bell

if grep -q "arch4k" /etc/hostname; then
  # Nvidia
  xrandr --setprovideroutputsource modesetting NVIDIA-0
  # HiDPI
  xrandr --dpi 192
  [ -f "$HOME/.Xresources.hidpi" ] && xrdb -merge "$HOME/.Xresources.hidpi"
  # Double the GTK+3 widget scale. NOTE: You must set the GTK+3 font to half size. Hopefully this changes soon.
  export GDK_SCALE=2
  export GDK_DPI_SCALE=0.5
  # This seems to make HiDPI terrible for zoom. investigate..
  export QT_AUTO_SCREEN_SCALE_FACTOR=1
  export QT_STYLE_OVERRIDE=Breeze
else
  # Regular DPI
  [ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"
fi

# render Java apps less horribly
export _JAVA_AWT_WM_NONREPARENTING=1

# if Kinesis keyboard is not plugged in, swap caps and escape
if ! cat /sys/bus/usb/devices/*/product | grep -q "Advantage2"; then
  setxkbmap -option caps:swapescape
fi

# autostart

if test -f /usr/bin/gnome-keyring-daemon; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
fi

if test -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1; then
  /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

/usr/local/bin/slstatus &

# set wm background color
 xsetroot -solid "#0184BC"

exec dwm 2> /tmp/dwm.log
