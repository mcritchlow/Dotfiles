local ok, wk = pcall(require, "which-key")

if not ok then
    return
end

-- terminal mode
wk.register({
    ["<C-o>"] = { "<C-\\><C-n>", "[TERMINAL] Exit to Normal mode" },
}, { mode = "t", noremap = true })

-- insert mode
wk.register({
    ["<C-g>a <C-o>"] = { "<cmd>lua require('telescope').extensions.githubcoauthors.coauthors()<CR>", "[TELESCOPE] Git co-authors" },
}, { mode = "i", noremap = true })

-- vsnip mappings
local vsnip_mappings = {
		['<C-j>'] = { "vsnip#expandable() ? '<Plug>(vsnip-expand)': '<C-j>'", '[VSNIP] expand', expr=true},
		['<C-l>'] = { "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)': '<C-l>'", '[VSNIP] expand or jump', expr=true},
		['<Tab>'] = { "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)': '<Tab>'", '[VSNIP] jump to next', expr=true},
		['<S-Tab>'] = { "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'", '[VSNIP] jump to previous', expr=true},
}
wk.register(vsnip_mappings, {mode = 'i'})
wk.register(vsnip_mappings, {mode = 's'})

-- normal mode
local normal_opts = {
    mode = "n",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}
wk.register({
    ["Y"] = { "Y$", "Y behaves like C and D" },
    ["n"] = { "nzz", "[MOVEMENT] Center 'n' search" },
    ["N"] = { "Nzz", "[MOVEMENT] Center 'N' search" },
    ["*"] = { "*zz", "[MOVEMENT] Center '*' search" },
    ["#"] = { "#zz", "[MOVEMENT] Center '#' search" },
    ["g*"] = { "g*zz", "[MOVEMENT] Center 'g*' search" },
    ["g#"] = { "g#zz", "[MOVEMENT] Center 'g#' search" },
    ["<leader><leader>"] = { "<c-^>", "[MOVEMENT] Last file" },
    ["<c-j"] = { "<c-w>j", "[MOVEMENT] Down" },
    ["<c-k"] = { "<c-w>k", "[MOVEMENT] Up" },
    ["<c-h"] = { "<c-w>h", "[MOVEMENT] Left" },
    ["<c-l"] = { "<c-w>l", "[MOVEMENT] Right" },
    ["<c-n>"] = { "<cmd>NvimTreeToggle<cr> <cmd>NvimTreeRefresh<cr>", "[NVIMTREE] Toggle" },

    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()", "[LSP] Previous diagnostic" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()", "[LSP] Next diagnostic" },
    ["<leader>l"] = {
        name = "[LSP]",
        e = { "<cmd>lua vim.diagnostic.open_float()<cr>", "[LSP] View diagnosticson cursor" },
    },
    ["<leader>f"] = {
        name = "[TELESCOPE]",
        b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
        c = { "<cmd>lua require('mcritchlow.plugins.config.telescope').git_commits_with_sha()<cr>", "[TELESCOPE] Marks" },
        d = { "<cmd>lua require('mcritchlow.plugins.config.telescope').search_dotfiles()<cr>", "[TELESCOPE] Marks" },
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
}, normal_opts)

wk.setup {}
