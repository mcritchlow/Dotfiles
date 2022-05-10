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

-- Set borders
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

-- we want no virtual_text but show via hover
vim.diagnostic.config({
  virtual_text = false,
})

-- and we'd like nice symbols
local signs = require("mcritchlow.utils").signs
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- TODO: determine if we still need
-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
--     return t "<Plug>(vsnip-expand-or-jump)"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     return vim.fn['compe#complete']()
--   end
-- end
-- _G.s_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-p>"
--   elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
--     return t "<Plug>(vsnip-jump-prev)"
--   else
--     return t "<S-Tab>"
--   end
-- end
