# TODO:
# 1. Move aliases into separate file and source (+bashrc. too)
# 2. Move functions into separate file and source(+bashrc too)
# give us access to ^Q
stty -ixon

autoload -Uz compinit colors
colors
compinit

setopt promptsubst COMPLETE_ALIASES extendedglob hist_ignore_all_dups hist_ignore_space

# Things to source
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}
# Allow exported PS1 variable to override default prompt.
if ! env | grep -q '^PS1='; then
  PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '
fi


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
# aliases
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cd.='cd ..'
alias cd..='cd ..'
alias ccat='highlight --force --out-format=ansi'
alias l='ls -alFh --color=auto'
alias ll='ls -lh --color=auto'
alias sls="stat -c '%n (%F) %a %A' *"
alias swapcaps='setxkbmap -option caps:swapescape' #when no kinesis

# dirs
alias gm="cd ~/Music/"
alias gpx="cd ~/Pictures/"
alias gvd="cd ~/Videos/"
alias gdn="cd ~/Downloads/"
alias gdo="cd ~/Documents/"

# projects
alias gd="cd ~/projects/personal/dotfiles/"
alias gdv="cd ~/projects/personal/dotfiles/ && vim"
# project bases
alias gw="cd ~/projects/ucsd/"
alias gp="cd ~/projects/personal/"
alias gaur="cd ~/projects/aur/"

# operational
alias vi='vim'
alias vi2='vi -O2 '
alias hc="history -c"
alias which='type -p'
alias k5='kill -9 %%'
alias gst='git status'
alias gv='vim +GV +"autocmd BufWipeout <buffer> qall"'

# arch
alias pacman-update="clear && echo pacman hungry! | figlet && sudo pacman -Syu --noconfirm && echo pacman full! | figlet"
alias aur-update="clear && echo AUR time! | figlet && cd ~/projects/personal/laptop/ && ansible-playbook aur.yml --skip-tags work"
alias checkupdates="checkupdates | less"
alias aur-update-work="clear && echo AUR time! | figlet && cd ~/projects/personal/laptop/ && ansible-playbook aur.yml"
alias orphans="pacman -Qdt"
alias remove-orphans="sudo pacman -Rns \$(pacman -Qtdq)"

# Newsboat
# load shared read file then open
alias newsboat="newsboat -qI ~/projects/personal/sync-stuff/newsboat.read && newsboat"

# Tmux
# alias tmux="TERM=xterm-256color tmux"
alias tls="tmux ls"
alias td="tmux detach"

# Lastpass
alias lplogin='lpass login --trust matt@critchlow.xyz'
alias lploginwork='lpass login --trust mcritchlow@ucsd.edu'

# Brightlight shortcuts
alias br100='brightlight -p -w 100'
alias br50='brightlight -p -w 50'
alias br25='brightlight -p -w 25'

# Music (mpd + mpc)
alias mpcPlaylistReset='mpc update --wait && mpc clear && mpc ls | mpc add'

# Cowsay + Ansible
alias ansible-playbook-random='ANSIBLE_COW_SELECTION=random ansible-playbook'
alias ansible-playbook-tux='ANSIBLE_COW_SELECTION=tux ansible-playbook'

# Docker
alias docker-nuke='docker system prune -f --all --volumes'

# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
