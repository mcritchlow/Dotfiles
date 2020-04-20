" vim: set foldmethod=marker foldlevel=99:
" ============================================================================
" Core Settings {{{
" ============================================================================
let mapleader = ","
" use \ instead of comma for reverse f-searches
noremap \ ,

if &compatible
  set nocompatible
end
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.cache
set directory=~/.cache
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ignorecase    " ignore case in search patterns
set smartcase     " override ignorecase if search container upper case characthers
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set cursorline
set relativenumber
set hlsearch
set smartcase     " Case insensitive searches become sensitive with capitals
set smarttab      " sw at the start of the line, sts everywhere else
set ttimeoutlen=50  " Make Esc work faster
set visualbell

" look in git directory for tags too
set tags^=.git/tags

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Search/Find
set wildmenu
set wildignore+=tmp/**,**/node_modules/**
set wildmode=list:longest,list:full
" remove legacy path entry
set path-=/usr/include
" have find recursively search working directory vim started in
set path+=**

" Make it obvious where 120 characters is
set textwidth=120
set colorcolumn=+1

" Simple statusline
set statusline=%<%F\ %y\ %q%h%m%r%=%-14.(%03l,%02c%V%)\ %P

" Numbers
set number
set numberwidth=5

" Ruby
let g:ruby_indent_block_style = 'do'
let ruby_spellcheck_strings = 1

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set dictionary+=/usr/share/dict/words
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" }}}
"  ============================================================================
" Load Plugins {{{
" ============================================================================
" minpac commands:
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
" setup minpac
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

" }}}
" ============================================================================
" Load theme {{{
" ============================================================================
syntax enable
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme monotone
if exists('*term_setansicolors')
  let g:terminal_ansi_colors = repeat([0], 16)

  let g:terminal_ansi_colors[0] = "#403E41"
  let g:terminal_ansi_colors[8] = "#727072"

  let g:terminal_ansi_colors[1] = "#FF6188"
  let g:terminal_ansi_colors[9] = "#FF6188"

  let g:terminal_ansi_colors[2] = "#A9DC76"
  let g:terminal_ansi_colors[10] = "#A9DC76"

  let g:terminal_ansi_colors[3] = "#FFD866"
  let g:terminal_ansi_colors[11] = "#FFD866"

  let g:terminal_ansi_colors[4] = "#399EE6"
  let g:terminal_ansi_colors[12] = "#399EE6"

  let g:terminal_ansi_colors[5] = "#AB9DF2"
  let g:terminal_ansi_colors[13] = "#AB9DF2"

  let g:terminal_ansi_colors[6] = "#78DCE8"
  let g:terminal_ansi_colors[14] = "#78DCE8"

  let g:terminal_ansi_colors[7] = "#FCFCFA"
  let g:terminal_ansi_colors[15] = "#FCFCFA"
endif

" }}}
" ============================================================================
" Autocommands {{{
" ============================================================================

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" }}}
" ============================================================================
" General Mappings {{{
" ============================================================================
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Center current search on screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Open urlview on current file
nnoremap <leader>u :w<Home>silent <End> !urlscan<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Show list of TODO entries
" Ignore tmp folder in projects, usually Hydra-based ones
noremap <Leader>T :noautocmd vimgrep /TODO/j **/*.*<CR>:cw<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" }}}
" ============================================================================
" Plugin Configurations {{{
" ============================================================================
" Individual plugin mappings and settings
" ============================================================================
" Vim Markdown {{{
" ============================================================================

let g:markdown_fenced_languages = [
      \ 'javascript',
      \ 'ruby',
      \ 'sh',
      \ 'yaml',
      \ 'javascript',
      \ 'html',
      \ 'vim',
      \ 'json',
      \ 'diff',
      \ 'css',
      \ 'scss',
      \ 'python'
      \ ]

" }}}
" ============================================================================
" Ale (linters) {{{
" ============================================================================
" Shorten error/warning flags
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
" Disable or enable loclist at the bottom of vim
let g:ale_open_list = 0
let g:ale_loclist = 0

let g:ale_fixers = {
      \  'ruby':['rubocop']
      \ }

let g:ale_linters = {
      \  'ruby':['rubocop'],
      \  'python': ['pylint'],
      \  'java': ['javac'],
      \  'shell': ['shellcheck'],
      \  'ansible': ['ansible-lint']
      \ }
" }}}
" ============================================================================
" Vim Test {{{
" ============================================================================
" vim-test sends command to send to tmux usign Vim Tmux Runner
let test#strategy = "vtr"
" vim-test mappings
nnoremap <silent> <Leader>f :TestFile<CR>
nnoremap <silent> <Leader>t :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>s :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" }}}
" ============================================================================
" Ansible {{{
" ============================================================================
" indentation will completely reset (unindent to column 0) after two newlines in insert-mode.
let g:ansible_unindent_after_newline = 1
" }}}
" Go {{{
" ============================================================================
" Fix imports and formatting on save
let g:go_fmt_command = "goimports"
" disable fmt on save, use :GoFmt as needed
let g:go_fmt_autosave = 0
" }}}
" ============================================================================
" Editor Config {{{
" ============================================================================
" }}}
" ============================================================================
" FZF {{{
" ============================================================================
" use FZF like CTRL-P
nnoremap <c-p> :Files<cr>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" Add quickfix option
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Use new fancy vim popup window for fzf
" TODO: uncomment once this doesn't always revert to line 0
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

" Customize fzf colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" manage selected line from GitLineHistory search result
" for now, read commit into a vsplit
function! s:git_log_lines_handler(lines)
    if len(a:lines) < 2 | return | endif
    let parts = split(a:lines[1], ' ')
    echom parts[0]
    vnew
    setlocal buftype=nofile bufhidden=wipe filetype=gitcommit nobuflisted noswapfile nowrap
    execute 'silent! read !git show '. parts[0]
    execute 'normal!gg'
endfunction

" show commit history for a given line
command! -nargs=* GitLineHistory call fzf#run({
  \ 'source':  printf('git log --oneline --no-patch -L %s,%s:%s', line('.'), line('.'), shellescape(expand("%"))),
  \ 'sink*':    function('<sid>git_log_lines_handler'),
  \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x '.
  \            '--reverse '.
  \            '--preview="git show --color=always {1}" '.
  \            '--color hl:68,hl+:110'
  \ })

function! s:git_coauthors_handler(lines)
  let authors_template = ["Co-authored-by:"]
  call add(authors_template, a:lines[0])
  call append(line('.'), join(authors_template, " "))
endfunction

" find recent co-authors for commit message
command! -nargs=* GitCoAuthors call fzf#run({
  \ 'source':  'git log --pretty=format:"%an <%ae>" -1000 | sort | uniq',
  \ 'sink*':    function('<sid>git_coauthors_handler'),
  \ 'options': '--ansi '.
  \            '--reverse '.
  \            '--color hl:68,hl+:110'
  \ })
"
" }}}
imap <c-g>a <c-o>:GitCoAuthors<cr>

" Support local project settings, such as custom test commands, formatting, etc.
if filereadable(expand("vimrc.local"))
  exe 'source vimrc.local'
endif
