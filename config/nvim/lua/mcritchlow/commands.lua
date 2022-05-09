-- Format buffer using LSP
vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})
