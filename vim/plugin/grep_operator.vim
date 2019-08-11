if exists('g:loaded_grep_operator_plugin') || &compatible
  finish
endif
let g:loaded_grep_operator_plugin = 1

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

" Support grep for operator using <leader>g prefix
" examples:
" Normal mode:
" <leader>g giw
" <leader>g g2w
" <leader>g giW
" Visual mode (character only):
" viw<leader>g
" viW<leader>g
  function! s:GrepOperator(type)
    " save current content in unnamed buffer
    let saved_unnamed_register = @@

    " only support character-wise visual selection or normal mode (on current word)
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! " . shellescape(@@) . " ."
    copen
    redraw!

    " place back original content in unnamed buffer
    let @@ = saved_unnamed_register
endfunction
