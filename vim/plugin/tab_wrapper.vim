if exists('g:loaded_tab_wrapper') || &compatible
  finish
endif
let g:loaded_tab_wrapper = 1

" will insert tab at beginning of line,
" will use completion if not at beginning
function s:InsertTabWrapper()
    let s:col = col('.') - 1
    if !s:col || getline('.')[s:col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <Tab> <c-r>=<SID>InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>
