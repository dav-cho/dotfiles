eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ -z "$TMUX" && -z "$VIM" ]]; then
  if [[ -n "$@" ]]; then
    command tmux "$@"
    return $?
  fi

  command tmux new-session -A -s '~default'

  if [[ $? -ne 0 ]]; then
    return
  fi

  exit
fi
