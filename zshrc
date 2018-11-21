# give us access to ^Q
stty -ixon

autoload -Uz compinit colors
colors
compinit

setopt promptsubst COMPLETE_ALIASES extendedglob hist_ignore_all_dups hist_ignore_space share_history

# Things to source
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.shared_shell/functions
source ~/.shared_shell/aliases

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}
# Allow exported PS1 variable to override default prompt.
if ! env | grep -q '^PS1='; then
  PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) %# '
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
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Per readme, source highlighting last since it wraps ZLE widgets
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
