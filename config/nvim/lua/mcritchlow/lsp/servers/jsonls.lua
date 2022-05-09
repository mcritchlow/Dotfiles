local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig.jsonls.setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
            }
        }
    }
end

return M
