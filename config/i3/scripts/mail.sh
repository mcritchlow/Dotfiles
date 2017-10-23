#!/bin/bash
if tmux ls | grep 'mail' > /dev/null; then
  tmux attach-session -t mail
else
  lplogin
  "$HOME/.tmux-projects/mail"
fi
