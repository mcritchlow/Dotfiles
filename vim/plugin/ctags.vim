if exists('g:loaded_ctags_plugin') || &compatible
  finish
endif
let g:loaded_ctags_plugin = 1

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
function s:ReindexCtags()
  let s:ctags_hook_file = "$(git rev-parse --show-toplevel)/.git/hooks/ctags"
  let s:ctags_hook_path = system("echo " . s:ctags_hook_file)
  let s:ctags_hook_path = substitute(s:ctags_hook_path, '\n\+$', '', '')

  if filereadable(expand(s:ctags_hook_path))
    exec '!'. s:ctags_hook_file
  else
    exec "!ctags -R ."
  endif
endfunction
nmap <Leader>ct :call <SID>ReindexCtags()<CR>
