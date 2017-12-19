" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" Core Settings {{{
" ============================================================================
let mapleader = ","

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set cursorline
set relativenumber
set hlsearch
"clear search by hitting return
nnoremap <CR> :noh<CR><CR>

set smartcase     " Case insensitive searches become sensitive with capitals
set smarttab      " sw at the start of the line, sts everywhere else
set ttimeoutlen=50  " Make Esc work faster
set visualbell

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab



" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Make it obvious where 120 characters is
set textwidth=120
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Folding
set foldlevelstart=-1
" Ruby
let ruby_fold = 1
let ruby_foldable_groups = 'class module def' "only fold higher level groups
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


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Bracketed paste
" http://www.xfree86.org/current/ctlseqs.html#Bracketed%20Paste%20Mode
" http://stackoverflow.com/a/7053522
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    vmap <expr> <Esc>[200~ XTermPasteBegin("c")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

" }}}
"  ============================================================================
" Load Plugins {{{
" ============================================================================

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

" }}}
" ============================================================================
" Load theme {{{
" ============================================================================
syntax enable
if $COLORTERM == "truecolor"
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  colorscheme solarized8_high
  let g:solarized_term_italics = 1
  " other diff modes: bold, normal
  let g:solarized_diffmode = "high"
else
  set t_Co=256
  colorscheme solarized
endif
set background=light
" Italicize comments
highlight Comment cterm=italic
" toggle background btw light/dark
call togglebg#map("<F5>")

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

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.html.erb set filetype=html
  autocmd BufNewFile,BufRead *.css.scss set filetype=css
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

  "Make calcurse notes markdown compatible:
  autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
  autocmd BufRead,BufNewFile ~/.config/calcurse/notes/* set filetype=markdown

  " setup mutt usage
  autocmd BufRead,BufNewFile /tmp/mutt-* setlocal spell nolist

  " set space/tab settings for languages
  autocmd FileType python set tabstop=4|set width=79|set shiftwidth=4|set expandtab|set autoindent
  autocmd FileType ruby set tabstop=2|set sw=2
  autocmd FileType html set tabstop=2|set sw=2
  autocmd FileType css set tabstop=2|set sw=2
  autocmd FileType javascript set tabstop=2|set sw=2

  " Enable spellchecking for LaTex
  autocmd FileType tex setlocal spell

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Use emoji complete for Markdown
  autocmd FileType markdown setlocal completefunc=emoji#complete

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " use blinking pipe bar (5) in insert mode
  au InsertEnter * silent execute "!echo -en \<esc>[5 q"
  " use block cursor (2) otherwise
  au InsertLeave * silent execute "!echo -en \<esc>[2 q"

augroup END

" }}}
" ============================================================================
" Tab Completion {{{
" ============================================================================
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" }}}
" ============================================================================
" Solarized Theme Toggle {{{
" ============================================================================
" :ToggleBG will switch main theme btw light/dark, but not vim-airline. This does both.
function! ToggleSolarizedTheme()
    let g:airline_solarized_bg = ( g:airline_solarized_bg == "dark" ? "light" : "dark" )
    :ToggleBG
    :AirlineRefresh
endfunction
nnoremap <F6> :call ToggleSolarizedTheme()<cr>

" }}}
" ============================================================================
" Markdown Preview {{{
" ============================================================================
" pandoc , markdown
function! MarkdownPreview()
  :RunSilent pandoc -f markdown_github -o /tmp/vim-pandoc-out.html %
  :RunSilent xdg-open /tmp/vim-pandoc-out.html
endfunction
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nnoremap <F7> :call MarkdownPreview()<cr>
" }}}
" ============================================================================
" Ctags {{{
" ============================================================================
" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" }}}
" ============================================================================
" General Mappings {{{
" ============================================================================
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Copy visual selection to clipboard
vnoremap <C-c> :w !xclip -sel c<CR><CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Show list of TODO entries
" Ignore tmp folder in projects, usually Hydra-based ones
set wildignore+=tmp/**
noremap <Leader>T :noautocmd vimgrep /TODO/j **/*.*<CR>:cw<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>


" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

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
" Syntastic {{{
" ============================================================================
" Folding
" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_ansible_checkers = ['ansible_lint']
" configure syntastic syntax checking to check on open as well as save
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" }}}
" ============================================================================
" Vim Test {{{
" ============================================================================
" vim-test sends command to send to tmux usign Vim Tmux Runner
let test#strategy = "vtr"
" use vim-tmux-runner keybindings. E.g. <leader>fr = focus runner
let g:VtrUseVtrMaps = 1
" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>

" }}}
" ============================================================================
" Seeing Is Believing (Ruby) {{{
" ============================================================================
" Annotate every line
nmap <leader>b :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk<CR>;
" Annotate marked lines
nmap <leader>n :%.!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk --xmpfilter-style<CR>;
" Remove annotations
nmap <leader>c :%.!seeing_is_believing --clean<CR>;
" Mark the current line for annotation
nmap <leader>m A # => <Esc>
" Mark the highlighted lines for annotation
vmap <leader>m :norm A # => <Esc>

" }}}
" ============================================================================
" Airline {{{
" ============================================================================
" install powerline fonts via https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" }}}
" ============================================================================
" Ansible {{{
" ============================================================================
" indentation will completely reset (unindent to column 0) after two newlines in insert-mode.
let g:ansible_unindent_after_newline = 1
" }}}
" ============================================================================
" Limelight {{{
" ============================================================================

let g:limelight_conceal_ctermfg = 245
let g:limelight_conceal_guifg = '#8a8a8a'

" }}}
" ============================================================================
" FZF {{{
" ============================================================================
" use FZF like CTRL-P
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <c-p> :Files<cr>

" File preview using Highlight (http://www.andre-simon.de/doku/highlight/en/highlight.php)
" let g:fzf_files_options =
"   \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
" TODO: test some of these out
" inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
" imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

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

" split Ag line into parts
function! s:ag_to_qf(line)
    let parts = split(a:line, ':')
    return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
            \ 'text': join(parts[3:], ':')}
endfunction

" manage selected line from search result
function! s:ag_handler(lines)
    if len(a:lines) < 2 | return | endif

    let cmd = get({'ctrl-x': 'split',
                  \ 'ctrl-v': 'vertical split',
                  \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
    let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

    let first = list[0]
    execute cmd escape(first.filename, ' %#\')
    execute first.lnum
    execute 'normal!' first.col.'|zz'

    if len(list) > 1
      call setqflist(list)
      copen
      wincmd p
    endif
endfunction

" bundler show command integration via fzf/ag
" https://github.com/junegunn/fzf/wiki/Examples-(vim)#narrow-ag-results-within-vim
command! -nargs=* Bsearch call fzf#run({
  \ 'source':  printf('ag --nogroup --column --color "%s" $(bundle show --paths)',
  \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
  \ 'sink*':    function('<sid>ag_handler'),
  \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
  \            '--multi --reverse --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
  \            '--color hl:68,hl+:110',
  \ 'down':    '50%'
  \ })

" need to get filename and line number to open
" fun! s:bundle_search(e)
"   let result_list = split(a:e, ':')
"   :e +result_list[0].' '.result_list[1]
"   echom 'Chosen file is' . result_list[0] . ' with line number' . result_list[1]
" endfun
"
" command! -bang -nargs=* Bsearch call fzf#run(
"       \ {
"       \ 'source': 'ag '.<q-args>.' $(bundle show --paths)',
"       \ 'sink': function('<sid>bundle_search'),
"       \ 'options': '-m',
"       \ 'down': '40%'
"       \ })

" custom FZF command borrowed from @dkarter
fun! s:change_branch(e)
  let l:_ = system('git checkout ' . a:e)
  :e!
  :AirlineRefresh
  echom 'Changed branch to' . a:e
endfun

command! Gbranch call fzf#run(
      \ {
      \ 'source': 'git branch',
      \ 'sink': function('<sid>change_branch'),
      \ 'options': '-m',
      \ 'down': '20%'
      \ })

fun! s:change_remote_branch(e)
  let l:_ = system('git checkout --track ' . a:e)
  :e!
  :AirlineRefresh
  echom 'Changed to remote branch' . a:e
endfun

command! Grbranch call fzf#run(
      \ {
      \ 'source': 'git branch -r',
      \ 'sink': function('<sid>change_remote_branch'),
      \ 'options': '-m',
      \ 'down': '20%'
      \ })


" }}}

" }}}
