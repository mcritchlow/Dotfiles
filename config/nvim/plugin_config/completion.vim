set completeopt=menu,menuone,noselect
lua << EOF
-- LSP settings
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>:Telescope lsp_definitions()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufrn, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>:Telescope lsp_implementations<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>:Telescope lsp_references<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>:Telescope lsi_code_actions<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

nvim_lsp.bashls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    bashIde = {
      highlightParsingErrors = false -- let shellcheck do this
    }
  }
}

nvim_lsp.ansiblels.setup{
  filetypes = { "yaml.ansible", "yaml" },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- TODO not working well for helm files..
local util = require 'lspconfig/util'
local repo_root = util.root_pattern(".git")(vim.fn.getcwd())
-- nvim_lsp.yamlls.setup {
--   filetypes = { "yaml" },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

local sumneko_root_path = vim.fn.getenv("HOME").."/projects/personal/lua-language-server" -- Change to your sumneko root installation
local sumneko_binary_path = "/usr/bin/lua-language-server" -- Change to your OS specific output folder
local luadev = require("lua-dev").setup({
  lspconfig = {
      cmd = {sumneko_binary_path, "-E", sumneko_root_path.."/main.lua" },
      on_attach = on_attach,
      settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    globals = {'vim'},
                },
                workspace = {
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
      },
  },
})
nvim_lsp.sumneko_lua.setup(luadev)

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

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- Compe setup
local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    },
    documentation = {
      border = 'single',
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'vsnip' },
      { name = 'buffer',
          options = {
            get_bufnrs = function()
               return vim.api.nvim_list_bufs()
            end
          }
      },
      { name = 'path' },
    },
    formatting = {
      format = require("lspkind").cmp_format({with_text = true, menu = ({
          buffer = "[Buffer]",
          path = "[Path]",
          nvim_lsp = "[LSP]",
          vsnip = "[Snippet]",
          nvim_lua = "[Lua]",
        })}),
    },

})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set borders
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

--vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- For testing
vim.lsp.set_log_level("debug")
EOF
