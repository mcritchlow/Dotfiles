if exists('g:loaded_git_browse') || &compatible
  finish
endif
let g:loaded_git_browse = 1

function s:GitBrowse()
  execute ":silent !browse-git-url " . shellescape(expand("%:p")) . " " . line("w0") . " " . line("w$")
  execute ':redraw!'
endfunction

" define mapping poings
command GitBrowse call <SID>GitBrowse()
