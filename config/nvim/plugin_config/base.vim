" ============================================================================
" Plug {{{
" ============================================================================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(stdpath('data') . '/plugged')

" Define bundles via Github repos
" ============================================================================
" Ruby/Rails {{{
" ============================================================================
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise' " add end after if, do, def

" }}}
" ============================================================================
" Testing/Validation {{{
" ============================================================================
Plug 'janko-m/vim-test'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
" }}}
" ============================================================================
" General Nice Things {{{
" ============================================================================
Plug 'ConradIrwin/vim-bracketed-paste' "enable bracketed paste
Plug 'tpope/vim-repeat' "repeat map commands (surround)
Plug 'tpope/vim-unimpaired' " [ and ] mappings for quickfix, buffers, etc.
Plug 'bronson/vim-trailing-whitespace' "make trailing whitespace annoying
Plug 'tpope/vim-markdown' "add folding to markdown files
Plug 'tpope/vim-fugitive' "git integration
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } "nvim in...browser!

" }}}
" ============================================================================
" Theming {{{
" ============================================================================
Plug 'sainnhe/sonokai'
"commented out temporarily. need to get universal-ctags or other ruby friendly parser in
" Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-emoji' "because emoji!

" }}}
" ============================================================================
" Custom Motions {{{
" ============================================================================
Plug 'tpope/vim-commentary' "comments w/ gc motion
Plug 'christoomey/vim-sort-motion' "sorting with gs motion
Plug 'tpope/vim-surround' " cs motion for changing quotes, tags, etc.
Plug 'junegunn/vim-easy-align' "text alignment for tables, etc.

" }}}
" ============================================================================
" Tmux {{{
" ============================================================================
Plug 'keith/tmux.vim'

" }}}
" ============================================================================
" Languages {{{
" ============================================================================
Plug 'sheerun/vim-polyglot'
Plug 'vim-ruby/vim-ruby'
Plug 'norcalli/nvim-colorizer.lua'

" }}}
" ============================================================================
" Fuzzy Finder (FZF) {{{
" ============================================================================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" }}}
" ============================================================================
" Custom Text Objects {{{
" ============================================================================
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
" }}}
call plug#end()
" }}}

