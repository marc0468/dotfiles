# tmux起動時処理
if [ "${TERM_PROGRAM}" = "vscode" ]; then
else
  if [[ ! -n $TMUX ]]; then
    # get the IDs
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
      tmux new-session
    fi
    ID="`echo $ID | $PERCOL | cut -d: -f1`"
    tmux attach-session -t "$ID"
  fi
fi