setlocal tabstop=2
setlocal sw=2
" Allow stylesheets to autocomplete hyphenated words
setlocal iskeyword+=-
let b:undo_ftplugin .= '|setlocal tabstop< sw< iskeyword<'
