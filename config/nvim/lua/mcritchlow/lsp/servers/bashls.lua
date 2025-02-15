local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig.bashls.setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
        settings = {
            bashIde = {
                highlightParsingErrors = true -- let shellcheck do this
            }
        }
    }
end

return M
