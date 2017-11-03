#!/bin/bash
if tmux ls | grep 'mail' > /dev/null; then
  tmux attach-session -t mail
else
  STATUS=$(lpass status)
  if [ "$STATUS" == "Not logged in." ]; then
    lplogin
  fi

  "$HOME/.tmux-projects/mail"
fi
