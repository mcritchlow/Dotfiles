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
    vim.opt_local.relative_number = false
  end,
  group = highlight_group,
})
