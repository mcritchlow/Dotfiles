-- Mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
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
map('n', '<leader><leader>','<c-^>')

-- Quicker window movement
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Terminal
map('t','<C-o>', '<C-\\><C-n>')

-- EasyAlign
map('n', 'ga', '<Plug>(EasyAlign)', { noremap = false })
map('x', 'ga', '<Plug>(EasyAlign)', { noremap = false })

-- VimTest

map('n', '<Leader>f', ':TestFile<CR>', silent)
map('n', '<Leader>t', ':TestNearest<CR>', silent)
map('n', '<Leader>l', ':TestLast<CR>', silent)
map('n', '<Leader>s', ':TestSuite<CR>', silent)
map('n', '<Leader>gt', ':TestVisit<CR>', silent)

-- TODO nvim-vsnip
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
--
-- telescope
require('telescope').load_extension('githubcoauthors')

-- telescope: files/words
map("n", "<Leader>ps", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>", silent)
map("n", "<Leader>pw", "<cmd>lua grep_string { search = vim.fn.expand('<cword>') }<CR>", silent)
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>", silent)
map("n", "<Leader>pf", "<cmd>lua require('telescope.builtin').git_files()<CR>", silent)


-- telescope: Vim helpers
map("n", "<Leader>vb", "<cmd>lua require('telescope.builtin').buffers()<CR>", silent)
map("n", "<Leader>vh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", silent)

-- telescope: git
map("n", "<Leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<CR>", silent)
map("n", "<Leader>gc", "<cmd>lua require('mcritchlow.config.telescope').git_commits_with_sha()<CR>", silent)
map("i", "<C-g>a <C-o>", "<cmd>lua require('telescope').extensions.githubcoauthors.coauthors()<CR>", silent)

-- telescope: dotfiles
map("n", "<Leader>vrc", "<cmd>lua require('mcritchlow.config.telescope').search_dotfiles()<CR>", silent)
