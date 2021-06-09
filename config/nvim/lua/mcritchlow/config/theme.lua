vim.opt.termguicolors = true
vim.opt.colorscheme = "sonokai"

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
-- Set truecolor fg color
vim.opt.t_8b = t("<Esc>").."[48;2;%lu;%lu;%lum"
-- Set truecolor bg color
vim.opt.t_8b = t("<Esc>").."[38;2;%lu;%lu;%lum"

vim.g.terminal_color_0 = "#181819"
vim.g.terminal_color_8 = "#181819"
vim.g.terminal_color_1 = "#FC5D7C"
vim.g.terminal_color_9 = "#FC5D7C"
vim.g.terminal_color_2 = "#9ED072"
vim.g.terminal_color_10 = "#9ED072"
vim.g.terminal_color_3 = "#E7C664"
vim.g.terminal_color_11 = "#E7C664"
vim.g.terminal_color_4 = "#76CCE0"
vim.g.terminal_color_12 = "#76CCE0"
vim.g.terminal_color_5 = "#B39DF3"
vim.g.terminal_color_13 = "#B39DF3"
vim.g.terminal_color_6 = "#F39660"
vim.g.terminal_color_14 = "#F39660"
vim.g.terminal_color_7 = "#E2E2E3"
vim.g.terminal_color_15 = "#E2E2E3"
