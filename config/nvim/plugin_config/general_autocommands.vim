augroup MyAutocmds
  autocmd!

  " Briefly highlight yanked text for visual feedback if it is what we want
  " on_yank parameters are highlight group and time (in ms)
  if exists('##TextYankPost')
    autocmd TextYankPost * lua require'vim.highlight'.on_yank {higroup='Substitute', timeout=300}
  endif

  " Fire Neovim
  au BufEnter github.com_*.txt set filetype=markdown
  au BufEnter gitlab.com_*.txt set filetype=markdown

  " turn off line numbers in terminal
  au TermOpen * setlocal listchars= nonumber norelativenumber
augroup end
