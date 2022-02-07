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

" }}}
" ============================================================================
" Testing/Validation {{{
" ============================================================================
Plug 'janko-m/vim-test'
Plug 'editorconfig/editorconfig-vim'
" }}}
" ============================================================================
" General Nice Things {{{
" ============================================================================
Plug 'ConradIrwin/vim-bracketed-paste' "enable bracketed paste
Plug 'tpope/vim-repeat' "repeat map commands (surround)
Plug 'tpope/vim-unimpaired' " [ and ] mappings for quickfix, buffers, etc.
Plug 'tpope/vim-markdown' "add folding to markdown files
Plug 'tpope/vim-fugitive' "git integration
Plug 'whiteinge/diffconflicts' "git merge conflicts less horrifying to look at
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } "nvim in...browser!

" }}}
" ============================================================================
" Theming {{{
" ============================================================================
Plug 'projekt0n/github-nvim-theme'
"commented out temporarily. need to get universal-ctags or other ruby friendly parser in
" Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-emoji' "because emoji!

" }}}
" ============================================================================
" Custom Motions {{{
" ============================================================================
Plug 'numToStr/Comment.nvim' "comments w/ gc motion
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
" Plug 'mcritchlow/refactoring.nvim'
" TODO: replace after get Ruby PR in
" Plug 'ThePrimeagen/refactoring.nvim' " Bring back once settled down a bit
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'folke/lua-dev.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-ruby/vim-ruby'
Plug 'norcalli/nvim-colorizer.lua'

" }}}
" ============================================================================
" Neovim Completion/LSP {{{
" ============================================================================
Plug 'b0o/SchemaStore.nvim' " for json-ls schemas
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'https://git.sr.ht/~mcritchlow/cmp-gitlab-issues'
Plug 'https://git.sr.ht/~mcritchlow/cmp-jira-issues'
Plug 'onsails/lspkind-nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
" }}}
" ============================================================================
" Snippets {{{
" ============================================================================
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
" }}}
" ============================================================================
" Fuzzy Finder (FZF) {{{
" ============================================================================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'cwebster2/github-coauthors.nvim'
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

