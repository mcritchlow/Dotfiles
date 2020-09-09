nnoremap <c-p> :Files<cr>
" additional fzf mappings
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>h :Helptags<cr>
nnoremap <Leader>T :Tags<cr>

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
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

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
