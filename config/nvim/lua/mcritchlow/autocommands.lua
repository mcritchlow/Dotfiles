-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = 'Substitute', timeout = 300 })
  end,
  group = highlight_group,
})

-- Don't show numbers and vim listchars in Terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.listchars = ''
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- replace ftdetect vim files:
-- TODO: turn into helper method?
vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.css.scss",
    callback = function()
        vim.opt.filetype = "css"
    end,
})
vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.html.erb",
    callback = function()
        vim.opt.filetype = "html"
    end,
})
vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = ".{jscs,jshint,eslint}rc",
    callback = function()
        vim.opt.filetype = "json"
    end,
})
vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*mutt-*",
    callback = function()
        vim.opt.filetype = "mail"
    end,
})
vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "/tmp/gitlab-*.mail",
    callback = function()
        vim.opt.filetype = "mail"
    end,
})
vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.{md,markdown}",
    callback = function()
        vim.opt.filetype = "markdown"
    end,
})
