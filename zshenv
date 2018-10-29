typeset -U path
# various bins
path=(~/.bin ~/bin ~/.local/bin $path[@])

# load Go
if test -d "$HOME/go"; then
  export GOPATH="$HOME/go"
  path=(~/go/bin $path[@])
  export PATH="$HOME/go/bin:$PATH"
fi

# load rbenv
if test -d "$HOME/.rbenv"; then
  path=(~/.rbenv/bin ~/.rbenv/plugins/ruby-build/bin $path[@])
  eval "$(rbenv init - )"
fi

export WWW_HOME="https://duckduckgo.com"
export EDITOR=vim
export VISUAL=vim
# Lastpass
export LPASS_PINENTRY="/usr/bin/pinentry-curses"
# don't allow agent to expire
export LPASS_AGENT_TIMEOUT=0
