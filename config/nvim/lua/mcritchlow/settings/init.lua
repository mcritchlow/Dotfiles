local utils = require "mcritchlow.utils"
local theme = require "mcritchlow.theme"

vim.g.mapleader = ","

-- TODO: what is this??
-- vim.cmd [[set fcs=eob:\ ]]
vim.cmd [[filetype plugin indent on]]

-- see: help option-list
local options = {
  background = "light",
  completeopt = { 'menuone', 'noinsert' },
  cursorline = true,
  fileencoding = "utf-8",
  ignorecase = true,
  noswapfile = true,
  number = true,
  numberwidth = 5,
  path = { ".", "**" },
  relativenumber = true,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  statusline = "%<%F %y %{FugitiveStatusline()} %q%h%m%r%=%-14.(%03l,%02c%V%) %P",
  t_8b = utils.replaceTermCodes("<Esc>").."[48;2;%lu;%lu;%lum",
  t_8f = utils.replaceTermCodes("<Esc>").."[38;2;%lu;%lu;%lum",
  tagcase = "followscs",
  termguicolors = true,
  textwidth = 120,
}


-- Append, prepend, etc. stuff
vim.opt.tags:append(".git/tags")
vim.opt.wildignore:prepend({ "tmp/**", "**/node_modules/**"})
vim.opt.diffopt:append('vertical')

for key, value in pairs(options) do
  vim.opt[key] = value
end

-- Setup theme
theme.init()
