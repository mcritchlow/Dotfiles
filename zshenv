typeset -U path
# various bins
path=(~/.vim/plugged/fzf/bin ~/bin ~/.local/bin $path[@])

[[ $XDG_CONFIG_HOME ]] || export XDG_CONFIG_HOME="$HOME/.config"

# load Go
if test -d "$HOME/go"; then
  export GOPATH="$HOME/go"
  path=(~/go/bin $path[@])
fi

export WWW_HOME="https://duckduckgo.com"
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="firefox"
export TERMINAL="alacritty"
# Lastpass
export LPASS_PINENTRY="/usr/bin/pinentry-curses"
# don't allow agent to expire
export LPASS_AGENT_TIMEOUT=0
