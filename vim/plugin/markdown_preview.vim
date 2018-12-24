function! MarkdownPreview()
  :RunSilent pandoc -f gfm -o /tmp/vim-pandoc-out.html %
  :RunSilent xdg-open /tmp/vim-pandoc-out.html
endfunction
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nnoremap <F7> :call MarkdownPreview()<cr>
