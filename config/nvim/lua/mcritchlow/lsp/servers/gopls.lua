local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"
    local go_caps = capabilities
    go_caps.textDocument = {
      completion = {
        completionItem = {
          commitCharactersSupport = true,
          deprecatedSupport = true,
          documentationFormat = { "markdown", "plaintext" },
          preselectSupport = true,
          insertReplaceSupport = true,
          labelDetailsSupport = true,
          snippetSupport = true,
          resolveSupport = {
            properties = {
              "documentation",
              "details",
              "additionalTextEdits",
            },
          },
        },
        contextSupport = true,
        dynamicRegistration = true,
      },
    }

    -- local path = require 'nvim-lsp-installer.core.path'
    -- local install_root_dir = path.concat { vim.fn.stdpath 'data', 'lsp_servers' }
    local ok_go, go = pcall(require, "go")

    if not ok_go then
      print("Go module not found!")
      return
    end

    -- local go_caps = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    local keymaps_func = require("mcritchlow.utils").keymaps

    -- TODO: setup dap
    go.setup({
      gopls_cmd = { vim.fn.stdpath 'data' .. 'lsp_servers/gopls/gopls' },
      fillstruct = 'gopls',
      dap_debug = false,
      dap_debug_gui = false,
      lsp_keymaps = keymaps_func,
      -- lsp_keymaps = false,
      -- lsp_cfg = false
      lsp_cfg = {
        capabilities = go_caps,
      }
    })

		-- local go_lsp_opts = require'go.lsp'.config()

    -- lspconfig.gopls.setup(go_lsp_opts)
    lspconfig.gopls.setup {
        on_attach = on_attach,
        filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            gopls = {
                analyses = { unusedparams = true, unreachable = false },
                codelenses = {
                  generate = true, -- show the `go generate` lens.
                  gc_details = true, --  // Show a code lens toggling the display of gc's choices.
                  test = true,
                  tidy = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                matcher = "Fuzzy",
                diagnosticsDelay = "500ms",
                experimentalWatchedFileDelay = "100ms",
                symbolMatcher = "fuzzy",
            }
        },
        capabilities = go_caps,
    }
end

return M
