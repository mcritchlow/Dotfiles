-- Settings
-- see: help option-list
vim.opt_global.mapleader = ','
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.noswapfile = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.tagcase = "followscs"
vim.opt.tags:append(".git/tags")
vim.opt.wildignore:prepend({ "tmp/**", "**/node_modules/**"})
vim.opt.textwidth = 120
vim.opt.colorcolumn:append(1)
vim.opt.statusline = "%<%F %y %{FugitiveStatusline()} %q%h%m%r%=%-14.(%03l,%02c%V%) %P"
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = { 'menuone', 'noinsert' }
vim.opt.diffopt:append('vertical')
vim.opt.path = { ".", "**" }
