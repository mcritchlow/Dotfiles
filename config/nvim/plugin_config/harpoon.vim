lua << EOF
require("harpoon").setup({
  projects = {
      ["$HOME/projects/ucsd/surfliner/tidewater"] = {
          term = {
              cmds = {
                  "docker-compose build && docker-compose up",
                  "docker-compose exec web bin/tidewater_consumer"
              }
          }
      },
      ["$HOME/projects/ucsd/surfliner/comet"] = {
          term = {
              cmds = {
                  "docker-compose build && docker-compose up",
              }
          }
      },
  }
})
EOF

" Terminal commands
" ueoa is first through fourth finger left hand home row.
" This just means I can crush, with opposite hand, the 4 terminal positions
"
" These functions are stored in harpoon.  A plugn that I am developing
nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

nnoremap <space><space>a :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <space><space>s :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <space><space>d :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <space><space>f :lua require("harpoon.ui").nav_file(4)<CR>
" Terminals needed: specs, compose
" terminal for (t)ests
nnoremap <silent><leader>tt :lua require("harpoon.term").gotoTerminal(1)<CR>
" terminal for (d)docker compose
nnoremap <silent><leader>td :lua require("harpoon.term").gotoTerminal(2)<CR>
" terminal for (e)xtra commands
nnoremap <silent><leader>te :lua require("harpoon.term").gotoTerminal(3)<CR>
nnoremap <silent><leader>cd :lua require("harpoon.term").sendCommand(2, 1)<CR>
nnoremap <silent><leader>ce :lua require("harpoon.term").sendCommand(3, 2)<CR>
