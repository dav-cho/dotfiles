eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ -n "$KITTY_PID" && -z "$TMUX" && -z "$VIM" ]]; then
  if [[ $# -gt 0 ]]; then
    command tmux "$@"
    return $?
  fi

  command tmux new-session -A -s '~default' || return

  exit
fi
