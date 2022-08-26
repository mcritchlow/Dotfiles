local ok, mason = pcall(require, "mason")

if not ok then
  return
end

-- Some LSP UI customization
local signs = require("mcritchlow.utils").signs
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Floating border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or { { " ", "FloatBorder" } }
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Set borders
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

-- we want no virtual_text but show via hover
vim.diagnostic.config({
  virtual_text = false,
})

local on_attach = function(client, bufnr)
  require("mcritchlow.utils").lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Install LSP servers
mason.setup {
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    },
  },
}

local servers = {
  "bashls",
  "dockerls",
  "gopls",
  "jsonls",
  "null-ls",
  "sumneko_lua",
  "terraformls",
  "yamlls",
}

require("mason-lspconfig").setup {
  ensure_installed = servers
}

for _, server in ipairs(servers) do
  require("mcritchlow.lsp.servers." .. server).setup(on_attach, capabilities)
end
