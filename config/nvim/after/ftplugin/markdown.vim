setlocal tabstop=4
setlocal sw=4
setlocal textwidth=80
" Enable spellchecking for Markdown
setlocal spell
" Use emoji complete for Markdown
setlocal completefunc=emoji#complete
let b:undo_ftplugin .= '|setlocal tabstop< sw< spell< textwidth< completefunc<'
