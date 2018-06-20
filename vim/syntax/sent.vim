" Vim syntax file
" Language: Sent
" Maintainer: Matt Critchlow
" Latest Revision: 20 May 2018

if exists("b:current_syntax")
  finish
endif

syn spell toplevel

syn keyword sentTodo contained TODO FIXME XXX NOTE
syn match sentComment "#.*$" contains=sentTodo
syn match sentCodeBlock '^\$.*$' display
syn match sentImage '^@.*$' display
syn match sentListItem /^\s*\%([-*+]\|\d\+\.\)\ze\s\+/ contained
syn region sentListItemLine start="^\s*\%([-*+]\|\d\+\.\)\s\+" end="$" oneline contains=sentListItem
" TODO: highlight first line in paragraph (slide title)

let b:current_syntax = "sent"

hi def link sentTodo        Todo
hi def link sentComment     Comment
hi def link sentCodeBlock    Statement
hi def link sentImage       Statement
hi def link sentListItem    Identifier
