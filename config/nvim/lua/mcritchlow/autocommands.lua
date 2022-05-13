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
local ftdetect_autocmds = {
  css = "*.css.scss",
  json = ".{jscs,jshint,eslint}rc",
  lua = ".nvimrc.lua",
  mail = "*neomutt-*",
  markdown = "*.{md,markdown}",
}
for filetype, pattern in pairs(ftdetect_autocmds) do
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
      pattern = pattern,
      callback = function()
          vim.opt.filetype = filetype
      end,
  })
end
