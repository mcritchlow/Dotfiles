set completeopt=menu,menuone,noselect
lua << EOF
-- treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
-- LSP settings
local nvim_lsp = require('lspconfig')
local saga = require'lspsaga'.init_lsp_saga()
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', "<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- Enable the following language servers
local servers = {'bashls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
  }
end

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

nvim_lsp.efm.setup{
  init_options = {documentFormatting = true},
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"sh"},
  settings = {
    rootMarkers = {".git/"},
    languages = {
      sh = {
        {lintCommand = 'shellcheck -f gcc -x', lintSource = 'shellcheck', lintFormats= {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}}
      }
    }
  }
}

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

-- nvim_lsp.sumneko_lua.setup {
--   cmd = {sumneko_binary_path, "-E", sumneko_root_path.."/main.lua" };
--   on_attach = on_attach,
--   settings = {
--       Lua = {
--           runtime = {
--               version = 'LuaJIT',
--               path = vim.split(package.path, ';'),
--           },
--           diagnostics = {
--               globals = {'vim'},
--           },
--           workspace = {
--               library = {
--                   [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--                   [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--               },
--           },
--       },
--   },
-- }

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
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'vsnip' },
      { name = 'buffer',
          opts = {
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
          nvim_lsp = "[LSP]",
          vsnip = "[Snippet]",
          nvim_lua = "[Lua]",
        })}),
    },

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
