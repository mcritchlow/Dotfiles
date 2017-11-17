
eval "$(ssh-agent -s)"

# for now, simple check for thinkpad
if hostname | grep 'solus-thinkpad' > /dev/null; then
  xrdb -merge "$HOME/.Xresources"
else
  # TODO: confirm is pango needs 96*x or if I can use actual DPI
  xrandr --dpi 192
  xrdb -merge "$HOME/.Xresources.hidpi"
  # Double the GTK+3 widget scale. NOTE: You must set the GTK+3 font to half size. Hopefully this changes soon.
  export GDK_SCALE=2
  export GDK_DPI_SCALE=0.5
  # Do the same with Qt5, the other Qt/KDE options do general things to make Qt5
  #export QT_DEVICE_PIXEL_RATIO=2
  export QT_SCALE_FACTOR=2
  export QT_STYLE_OVERRIDE=Breeze
  # export KDE_FULL_SESSION=1
  # export KDE_SESSION_VERSION=5
  # export SAL_USE_VCLPLUGIN=kde5
fi

# start urxvt daemon
urxvtd -q -f -o

exec dbus-launch --sh-syntax --exit-with-session i3
