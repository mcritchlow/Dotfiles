-- Format buffer using LSP
vim.api.nvim_create_user_command("Format", function(args)
  vim.lsp.buf.formatting()
  end, {
  desc = "Format buffer with LSP"
})
