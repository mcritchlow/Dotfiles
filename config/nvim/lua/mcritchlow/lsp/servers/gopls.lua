local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"
    local ok_go, go_lsp = pcall(require, "go.lsp")

    if not ok_go then
        return
    end

    -- lspconfig.lspconfig.setup(go_lsp.config())

    lspconfig.gopls.setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }
end

return M
