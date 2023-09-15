_tmux-run() {
  if [[ -n "$@" ]]; then
    command tmux "$@"
    return $?
  fi

  command tmux new-session -A -s '~default'

  if [[ $? -ne 0 ]]; then
    return
  fi

  exit
}

if [[ -z "$TMUX" && -z "$VIM" ]]; then
  _tmux-run
fi
