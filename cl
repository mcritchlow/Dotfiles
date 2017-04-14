# add colored output to less via highlight

function cl() {
  highlight -O ansi --failsafe $1 | less -R
}
