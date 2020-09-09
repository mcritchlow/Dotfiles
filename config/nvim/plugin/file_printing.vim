if exists('g:loaded_file_printing') || &compatible
  finish
endif
let g:loaded_file_printing = 1

function s:PrintMarkdownFile()
  :RunSilent pandoc -f markdown -o /tmp/vim-pandoc-out.pdf %
  :RunSilent lpr /tmp/vim-pandoc-out.pdf
endfunction

function s:PrintFile()
  :RunSilent lpr %
endfunction

" this might already be defined by markdown plugin
if !exists(":RunSilent")
  command -nargs=* RunSilent
        \ | execute ':silent !'.'<args>'
        \ | execute ':redraw!'
endif

" define mapping poings
command PrintMarkdownFile call <SID>PrintMarkdownFile()
command PrintFile call <SID>PrintFile()
