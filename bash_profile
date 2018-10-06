#
# ~/.bash_profile
#

# ensure dotfiles bin directory is loaded first
# here for both non-ineractive (dmenu) and interactive shells
export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/bin:$HOME/go/bin:$PATH"

[[ -f ~/.bashrc ]] && . ~/.bashrc
