-- Mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- For mappings we want to use silent
local silent = { silent = true }

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
-- Telescrope
-- Example
map("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], silent)

-- map('n', '<leader>ps'. telescope_builtin.grep_string({ search = vim.fn.input("Grep For > ")})<CR>)
-- map('n', '<C-p> :lua require('telescope.builtin').git_files()<CR>
-- map('n', '<Leader>pf :lua require('telescope.builtin').find_files()<CR>
-- map('n', '
-- map('n', '<leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
-- map('n', '<leader>pb :lua require('telescope.builtin').buffers()<CR>
-- map('n', '<leader>vh :lua require('telescope.builtin').help_tags()<CR>
-- map('n', '<leader>vrc :lua require('theprimeagen.telescope').search_dotfiles()<CR>
-- map('n', '<leader>va :lua require('theprimeagen.telescope').anime_selector()<CR>
-- map('n', '<leader>vc :lua require('theprimeagen.telescope').chat_selector()<CR>
-- map('n', '<leader>gc :lua require('theprimeagen.telescope').git_branches()<CR>
-- map('n', '<leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
-- map('n', '<leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
