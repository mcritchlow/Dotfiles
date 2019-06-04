if exists('g:loaded_git_browse') || &compatible
  finish
endif
let g:loaded_git_browse = 1

function s:OpenGitURL()
  let s:url = s:GitURL()
  execute ":silent !xdg-open " . shellescape(s:url,1)
  execute ':redraw!'
  echom "Opened " . s:url . " in browser.."
endfunction

function s:CopyGitURL()
  let s:url = s:GitURL()
  execute ":silent !echo " . shellescape(s:url,1) . " | xclip -r -sel clip"
  execute ':redraw!'
  echom "Copied " . s:url . " to clipboard.."
endfunction

function s:GitURL()
  if mode()=~#"^[vV\<C-v>]"
    let [firstline, lastline]=[line('v'), line('.')]
  else
    let [firstline, lastline]=[line("'<"), line("'>")]
  endif
  return system("git-url ". shellescape(expand("%:p")) . " " . firstline . " " . lastline . " | tr -d '\n'")
endfunction

" define mapping poings
command -range=% CopyGitURL call <SID>CopyGitURL()
command -range=% OpenGitURL call <SID>OpenGitURL()
