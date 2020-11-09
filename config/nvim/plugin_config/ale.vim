let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
" Disable or enable loclist at the bottom of vim
let g:ale_open_list = 0
let g:ale_loclist = 0

" container-based executable paths
" ruby
let g:ale_ruby_rubocop_executable = 'ale-rubocop'
let g:ale_ruby_rubocop_options = '--config .rubocop.yml'

let g:ale_json_jsonlint_executable = 'ale-jsonlint'
let g:ale_json_jsonlint_use_global = 1


let g:ale_fixers = {
      \  'ruby':['rubocop'],
      \  'json': ['jq']
      \ }

let g:ale_linters = {
      \  'ruby':['rubocop'],
      \  'python': ['pylint'],
      \  'java': ['javac'],
      \  'json': ['jsonlint'],
      \  'shell': ['shellcheck'],
      \  'ansible': ['ansible-lint']
      \ }
