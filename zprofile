# autostart X/dwm at login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# ensure dotfiles bin directory is loaded first
# here for both non-ineractive (dmenu) and interactive shells
export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/bin:$PATH"
