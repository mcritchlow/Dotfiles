lua require("mcritchlow.config.telescope")
lua require('telescope').load_extension('githubcoauthors')

" Mappings

" File and patterns
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pp :lua require('mcritchlow.config.telescope').file_browser()<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>

" Vim stuff
nnoremap <leader>vb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

" Git
nnoremap <leader>gb :lua require('telescope.builtin').git_branches()<CR>
nnoremap <leader>gc :lua require('mcritchlow.config.telescope').git_commits_with_sha()<CR>
inoremap <c-g>a <c-o>:lua require('telescope').extensions.githubcoauthors.coauthors()<CR>

" Extras
nnoremap <leader>vrc :lua require('mcritchlow.config.telescope').search_dotfiles()<CR>
