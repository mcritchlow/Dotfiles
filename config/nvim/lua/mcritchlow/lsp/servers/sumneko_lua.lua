local M = {}

M.setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")
    local luadev = require("lua-dev").setup({
      -- add any options here, or leave empty to use the default settings
      lspconfig = {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
      },
    })

    lspconfig.sumneko_lua.setup(luadev)
end

return M
