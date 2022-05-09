local ok, lsp_installer = pcall(require, "nvim-lsp-installer")

if not ok then
  return
end


local utils = require "utils"
local null_ls = require "lsp.servers.null-ls"

local servers = {
  "bashls",
  "sumneko_lua",
  "jsonls",
  "yamlls",
  "dockerls",
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>e', "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>:Telescope lsp_definitions<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>:Telescope lsp_implementations<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>:Telescope lsp_references<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>:Telescope lsp_code_actions<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Install LSP servers
lsp_installer.setup {
  ensure_installed = servers,
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    },
  },
}

for _, server in ipairs(servers) do
  require("mcrichlow.lsp.servers." .. server).setup(on_attach, capabilities)
end

-- Floating border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or { { " ", "FloatBorder" } }
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

--
-- Null-ls configuration
local null_ls = require("null-ls")
local null_ls_sources = {
  null_ls.builtins.diagnostics.shellcheck,
}

-- To register project-specific sources:
-- Set something like the following in a project vimrc.local file
-- local null_ls = require("null-ls")
-- local null_ls_sources = {
--   null_ls.builtins.diagnostics.standardrb.with({
--     command = "bin/null-ls-exec",
--     args = { "standardrb"," --no-fix", "-f", "json", "--stdin", "$FILENAME" },
--   }),
--   null_ls.builtins.formatting.standardrb.with({
--     command = "bin/null-ls-exec",
--     args = { "standardrb"," --fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
--   }),
-- }
-- null_ls.register(null_ls_sources)

null_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  sources = null_ls_sources
})
-- null_ls.setup({ debug = true, sources = null_ls_sources }) -- for DEBUG
