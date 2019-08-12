" TODO: expand this for other yard tags,  key off regexps to determine template
if exists('g:loaded_yard_tags_plugin') || &compatible
  finish
endif
let g:loaded_yard_tags_plugin = 1

" Add yard starter template for ruby method
nnoremap <leader>d :call <SID>YardTags()<cr>

function! s:YardTags()
  let params = s:MethodParams()
  let yard_tags = ["# <method definition here>", "#"]
  for param in params
    call add(yard_tags, "# @param " . param . " [T] <description of param>")
  endfor
  call add(yard_tags, "# @return [T] <description of return>")
  call append(line('.')-1, yard_tags)
  " indent appended lines (maybe a better way to do this) + select method definition line
  let indent_lines = len(yard_tags) - 1
  execute "normal! k>" . indent_lines . "kf<va<"
endfunction

" pull method parameters from definition line
" example: def method(p1, p2) will return ['p1','p2']
function! s:MethodParams()
  let line = getline('.')
  let line_array = split(line, '[()]')
  if len(line_array) == 1
    return []
  endif
  return split(line_array[1], ',')
endfunction
