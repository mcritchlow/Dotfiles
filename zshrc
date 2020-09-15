# give us access to ^Q
stty -ixon

autoload -Uz compinit promptinit
compinit
promptinit

setopt promptsubst COMPLETE_ALIASES extendedglob hist_ignore_all_dups hist_ignore_space share_history

# Things to source
source ~/.local/share/nvim/plugged/fzf/shell/key-bindings.zsh
source ~/.local/share/nvim/plugged/fzf/shell/completion.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.shared_shell/functions
[[ -f ~/.shared_shell/functions.local ]] && source ~/.shared_shell/functions.local
source ~/.shared_shell/aliases
[[ -f ~/.shared_shell/aliases.local ]] && source ~/.shared_shell/aliases.local

# Set autosuggest highlight to be more visible
typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git branch --show-current 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %B%F{green}($current_branch)%f%b"
  fi
}
# Allow exported PS1 variable to override default prompt.
if ! env | grep -q '^PS1='; then
  PS1='${SSH_CONNECTION+"%F{white}%%n@%m:"%F{white}%~%f$(git_prompt_info) %# '
fi

# Set GPG TTY
GPG_TTY=$(tty)
export GPG_TTY
# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

# autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select
# complete via sudo too
zstyle ':completion::complete:*' gain-privileges 1

# History
export HISTSIZE=10000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# enable help alias for zsh
autoload -Uz run-help
unalias run-help
alias help=run-help

# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey '^F' fzf-cd-widget #override Alt-C (because DWM..)

# make Vi-mode more obvious
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%B%F{yellow]} [% NORMAL]% %f%b"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Per readme, source highlighting last since it wraps ZLE widgets
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
