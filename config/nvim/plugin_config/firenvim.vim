let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }
let fc = g:firenvim_config['localSettings']
let fc['https://studio.youtube.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://.*gmail.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://.*retrium.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://.*lib-rancher-lb.ucsd.edu.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://.*notion.so.*'] = { 'takeover': 'never', 'priority': 1 }
