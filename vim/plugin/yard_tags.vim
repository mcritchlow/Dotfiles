if exists('g:loaded_yard_tags_plugin') || &compatible
  finish
endif
let g:loaded_yard_tags_plugin = 1

" Add yard starter template for ruby method
nnoremap <leader>d :call <SID>YardTags()<cr>

" Entrypoint function that delegates to tag type functions
function! s:YardTags()
  let current_line = getline('.')
  if current_line =~# '\v^\s+def.+'
    return s:MethodTags()
  elseif current_line =~# '\v^\s+attr_(accessor|writer|reader).+'
    return s:AttributeTags()
  else
    echom "cannot generate yard tags from this line.."
  endif
endfunction

" Generat a yard attribute template
function! s:AttributeTags()
  let yard_tags = ["# <attribute definition here>"]
  call add(yard_tags, "# @return [T] <description of attribute>")
  call append(line('.')-1, yard_tags)
  " indent appended lines (maybe a better way to do this) + select method definition line
  let indent_lines = len(yard_tags) - 1
  execute "normal! k>" . indent_lines . "kf<va<"
endfunction

" Generate a yard method template
function! s:MethodTags()
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
