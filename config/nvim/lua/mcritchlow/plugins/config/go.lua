local path = require 'nvim-lsp-installer.core.path'
local install_root_dir = path.concat { vim.fn.stdpath 'data', 'lsp_servers' }
local ok_go, go = pcall(require, "go")

if not ok_go then
  print("Go module not found!")
  return
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

go.setup({
  gopls_cmd = { install_root_dir .. '/go/gopls' },
  fillstruct = 'gopls',
  dap_debug = true,
  dap_debug_gui = true,
})
