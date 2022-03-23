set termguicolors
" Set truecolor fg color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" Set truecolor bg color
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
lua << EOF
vim.o.background = "light"
require("github-theme").setup({
  theme_style = "light",
  hide_inactive_statusline = false
})
EOF
