" vim: set foldmethod=marker foldlevel=99:
"
" _   _                 _
" | \ | | ___  _____   _(_)_ __ ___
" |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
" | |\  |  __/ (_) \ V /| | | | | | |
" |_| \_|\___|\___/ \_/ |_|_| |_| |_|
"
"

" ============================================================================
" Core Settings {{{
" ============================================================================
let mapleader = ","
" use \ instead of comma for reverse f-searches
noremap \ ,

set ignorecase    " ignore case in search patterns
set smartcase     " override ignorecase if search container upper case characthers
set noswapfile " swapfiles get really annoying w/ fg/bg jobs
set cursorline
set relativenumber
" set signcolumn=number "display signs in number column, or auto if none (default)
" look in git directory for tags too
set tagcase=followscs
set tags^=.git/tags
set wildignore+=tmp/**,**/node_modules/**
set textwidth=120 " Make it obvious where 120 characters is
set colorcolumn=+1

" Simple statusline
set statusline=%<%F\ %y\ %q%h%m%r%=%-14.(%03l,%02c%V%)\ %P

" Numbers
set number
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Autocomplete with dictionary words when spell check is on
set dictionary+=/usr/share/dict/words
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" }}}
"  ============================================================================
" Load Plugins and Theme {{{
" ============================================================================
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * call PlugInstall --sync | $MYVIMRC
endif

source $HOME/.config/nvim/plugin_config/base.vim
source $HOME/.config/nvim/plugin_config/theme.vim
" }}}

"  ============================================================================
" Load Plugin Configuration and Mappings {{{
" ============================================================================
source $HOME/.config/nvim/plugin_config/general_mappings.vim
source $HOME/.config/nvim/plugin_config/nvim_colorizer.vim
source $HOME/.config/nvim/plugin_config/easy_align.vim
source $HOME/.config/nvim/plugin_config/markdown.vim
source $HOME/.config/nvim/plugin_config/ale.vim
source $HOME/.config/nvim/plugin_config/vim_test.vim
source $HOME/.config/nvim/plugin_config/fzf.vim
" }}}

" Support local project settings, such as custom test commands, formatting, etc.
if filereadable(expand("vimrc.local"))
  source vimrc.local
endif
