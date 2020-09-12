augroup MyAutocmds
  autocmd!

  " Briefly highlight yanked text for visual feedback if it is what we want
  " on_yank parameters are highlight group and time (in ms)
  if exists('##TextYankPost')
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank('Substitute', 300)
  endif
augroup end
