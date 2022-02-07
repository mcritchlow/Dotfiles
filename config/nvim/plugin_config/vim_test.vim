let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'last':   'neovim',
  \ 'file':    'harpoon',
  \ 'suite':   'harpoon',
\}

nnoremap <silent> <Leader>f :TestFile<CR>
nnoremap <silent> <Leader>t :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>s :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>
