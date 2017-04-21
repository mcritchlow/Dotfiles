# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git current-branch 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}
setopt promptsubst
export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '

# add vi-mode indicator to RHS prompt
function zle-line-init zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
  RPS2=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# load our own completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion
autoload -U compinit
compinit

# load custom executable functions
#
for function in ~/.zsh/functions/*; do
  source $function
done

bundler-search() {
  # Search your bundle for the provided pattern
  #   Requires bundler 1.8+ for execution as a bundler subcommand.
  #   Examples:
  #     bundle search Kernal.warn
  #     bundle search current_user clearance
  #     bundle search "Change your password" clearance
  #
  # Arguments:
  #  1. What to search for
  #  2. Which gem names to search (defaults to all gems)

  pattern="$1"; shift
  ag "$pattern" $(bundle show --paths "$@")
  }

git-ctags() {
  [ -f .git/hooks/ctags ] || git init
  .git/hooks/ctags
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
export PATH="$HOME/bin:$PATH"
# load rbenv if available
if which rbenv &>/dev/null ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init - )"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi

# setup Base16 colorscheme config
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

if [ -n uname="Linux" ]; then
  [ -z "$TMUX" ] && export TERM=xterm-256color
fi
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

