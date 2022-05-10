local ok, wk = pcall(require, "which-key")

if not ok then
    return
end
--
-- Mappings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- For mappings we want to use silent
local silent = { silent = true }

-- Y behaves like C and D (to end of line)
map('n', 'Y', 'y$')

-- Center current search on screen
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '*', '*zz')
map('n', '#', '#zz')
map('n', 'g*', 'g*zz')
map('n', 'g#', 'g#zz')

-- Switch between the last two files
map('n', '<leader><leader>', '<c-^>')

-- Quicker window movement
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Terminal
map('t', '<C-o>', '<C-\\><C-n>')

local which_key_opts = {
    mode = "n",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}

require('telescope').load_extension('githubcoauthors')
wk.register({
    ["<C-g>a <C-o>"] = { "<cmd>lua require('telescope').extensions.githubcoauthors.coauthors()<CR>", "[TELESCOPE] Git co-authors" },
}, { mode = "i", noremap = true })

wk.register({
    ["<c-n>"] = { "<cmd>NvimTreeToggle<cr> <cmd>NvimTreeRefresh<cr>", "[NVIMTREE] Toggle" },

    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()", "[LSP] Previous diagnostic" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()", "[LSP] Next diagnostic" },
    ["<leader>l"] = {
        name = "[LSP]",
        e = { "<cmd>lua vim.diagnostic.open_float()<cr>", "[LSP] View diagnosticson cursor" },

    ["<leader>f"] = {
        name = "[TELESCOPE]",
        b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
        c = { "<cmd>lua require('mcritchlow.config.telescope').git_commits_with_sha()<cr>", "[TELESCOPE] Marks" },
        d = { "<cmd>lua require('mcritchlow.config.telescope').search_dotfiles()<cr>", "[TELESCOPE] Marks" },
        f = { "<cmd>Telescope find_files<cr>", "[TELESCOPE] Find buffers" },
        g = { "<cmd>Telescope git_branches<cr>", "[TELESCOPE] Git branches" },
        h = { "<cmd>Telescope help_tags<cr>", "[TELESCOPE] Help tags" },
        s = { "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>", "[TELESCOPE] Find work by grep" },
        w = { "<cmd>Telescope grep_string search=vim.fn.expand('<cword>')<cr>", "[TELESCOPE] Find word on cursor" },
    },

    ["<leader>t"] = {
        name = "[TEST]",
        f = { "<cmd>TestFile<cr>", "[TEST] Current file" },
        t = { "<cmd>TestNearest<cr>", "[TEST] Nearest test" },
        l = { "<cmd>TestLast<cr>", "[TEST] Last test" },
        s = { "<cmd>TestSuite<cr>", "[TEST] Test suite" },
        v = { "<cmd>TestVisit<cr>", "[TEST] Visit test" },
    },

    ["<leader>x"] = {
        name = "[TROUBLE]",
        x = { "<cmd>TroubleToggle<cr>", "[TROUBLE] Toggle menu" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "[TROUBLE] Workspace diagnostics" },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "[TROUBLE] Document diagnostics" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "[TROUBLE] Quickfix" },
        l = { "<cmd>TroubleToggle loclist<cr>", "[TROUBLE] Visit test" },
    },
}, which_key_opts)

wk.setup {}

-- TODO nvim-vsnip
-- how to do this in lua?
-- " Expand
-- imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
-- smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

-- " Expand or jump
-- imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
-- smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

-- " Jump forward or backward
-- imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
-- smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
-- imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
-- smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
