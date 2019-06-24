typeset -U path
# various bins
path=(~/bin ~/.local/bin $path[@])

# load Go
if test -d "$HOME/go"; then
  export GOPATH="$HOME/go"
  path=(~/go/bin $path[@])
fi

# load rbenv
export RBENV_ROOT="$HOME/projects/personal/rbenv"
export RBENV_DEFAULT_GEMS="$HOME/.config/rbenv/default-gems"
if test -d "$RBENV_ROOT"; then
  path=($RBENV_ROOT/bin $RBENV_ROOT/plugins/ruby-build/bin $path[@])
  eval "$(rbenv init - )"
fi

export WWW_HOME="https://duckduckgo.com"
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="firefox"
export TERMINAL="st"
# Lastpass
export LPASS_PINENTRY="/usr/bin/pinentry-curses"
# don't allow agent to expire
export LPASS_AGENT_TIMEOUT=0
# prefer libvirt provider for vagrant
export VAGRANT_DEFAULT_PROVIDER="libvirt"
# nnn scripts location
export NNN_SCRIPT="$HOME/.config/nnn/scripts"

# less colors
# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
# export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
# export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
# export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
# export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
# export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
# export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
# export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
# export LESS_TERMCAP_ue=$'\E[0m' # reset underline
