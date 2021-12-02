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
"
" common directory variables
let g:plugin_config_path = expand('$HOME/.config/nvim/plugin_config/')

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

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" Simple statusline
set statusline=%<%F\ %y\ %{FugitiveStatusline()}\ %q%h%m%r%=%-14.(%03l,%02c%V%)\ %P

" Numbers
set number
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Autocomplete with dictionary words when spell check is on
set dictionary+=/usr/share/dict/words
set completeopt=menuone,noselect
" set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Set path to project directory (and down)
set path=.,**

" Load project-specific .nvimrc files
set exrc

" }}}
"  ============================================================================
" Load Plugins and Theme {{{
" ============================================================================
execute 'source ' . g:plugin_config_path . 'base.vim'
execute 'source ' . g:plugin_config_path . 'theme.vim'
" }}}

"  ============================================================================
" Load Plugin Configuration and Mappings {{{
" ============================================================================
execute 'source ' . g:plugin_config_path . 'general_mappings.vim'
execute 'source ' . g:plugin_config_path . 'general_autocommands.vim'
execute 'source ' . g:plugin_config_path . 'firenvim.vim'
execute 'source ' . g:plugin_config_path . 'nvim_colorizer.vim'
execute 'source ' . g:plugin_config_path . 'easy_align.vim'
execute 'source ' . g:plugin_config_path . 'markdown.vim'
execute 'source ' . g:plugin_config_path . 'vim_test.vim'
execute 'source ' . g:plugin_config_path . 'telescope.vim'
execute 'source ' . g:plugin_config_path . 'nvim_vsnip.vim'
execute 'source ' . g:plugin_config_path . 'trouble.vim'
" execute 'source ' . g:plugin_config_path . 'fzf.vim'
execute 'source ' . g:plugin_config_path . 'completion.vim'
execute 'source ' . g:plugin_config_path . 'treesitter.vim'
" execute 'source ' . g:plugin_config_path . 'refactoring.vim'
" }}}
"
