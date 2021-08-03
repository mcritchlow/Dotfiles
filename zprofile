# autostart window manager at login
#
ENVIRONMENTD="$HOME/.config/environment.d"
set -a
if [ -d "$ENVIRONMENTD" ]; then
    for conf in $(ls "$ENVIRONMENTD"/*.conf)
    do
        . "$conf"
    done
fi
set +a

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
  exec sway > /tmp/sway.log 2>&1
fi
