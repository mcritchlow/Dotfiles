if exists('g:loaded_markdown_preview') || &compatible
  finish
endif
let g:loaded_markdown_preview = 1

function! MarkdownPreview()
  :RunSilent pandoc -f gfm -o /tmp/vim-pandoc-out.html %
  :RunSilent xdg-open /tmp/vim-pandoc-out.html
endfunction

" this might already be defined by printing plugin
if exists(':RunSilent') != 2
  command! -nargs=* RunSilent
        \ | execute ':silent !'.'<args>'
        \ | execute ':redraw!'
endif
nnoremap <F7> :call MarkdownPreview()<cr>
