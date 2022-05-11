local utils = require("mcritchlow.utils")
local theme = require("mcritchlow.theme")

vim.g.mapleader = ","

vim.cmd [[filetype plugin indent on]]

-- see: help option-list
local options = {
  background = "light",
  completeopt = { 'menuone', 'noinsert' },
  cursorline = true,
  fileencoding = "utf-8",
  ignorecase = true,
  swapfile = false,
  number = true,
  numberwidth = 5,
  path = { ".", "**" },
  relativenumber = true,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  statusline = "%<%F %y %{FugitiveStatusline()} %q%h%m%r%=%-14.(%03l,%02c%V%) %P",
  tagcase = "followscs",
  termguicolors = true,
  textwidth = 120,
}

utils.setSpacesSize { go = 4, python = 4, rust = 4, markdown = 4, css = 2, html = 2, javascript = 2 }

-- Append, prepend, etc. stuff
vim.opt.tags:append(".git/tags")
vim.opt.wildignore:prepend({ "tmp/**", "**/node_modules/**"})
vim.opt.diffopt:append('vertical')

for key, value in pairs(options) do
  vim.opt[key] = value
end

-- Setup theme
theme.init()
