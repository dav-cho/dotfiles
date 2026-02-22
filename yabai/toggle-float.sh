#!/usr/bin/env bash

if [ "$(yabai -m query --windows --window | jq '."is-floating"')" = "false" ]; then
  yabai -m window --toggle float
fi

if [ $# -eq 0 ]; then
  exit 0
fi

if [[ "$1" == "abs" ]]; then
  coords="$(
    jq \
      --argjson dx "$2" \
      --argjson dy "$3" \
      --argjson display "$(yabai -m query --displays --window | jq -r '.frame')" \
      -nr '($display.x + ($display.w - $dx) / 2 | tostring)
            + ":"
            + ($display.y + ($display.h - $dy - 25) / 2 | tostring)'
  )"
  yabai -m window --move "abs:$coords"
  yabai -m window --resize "abs:$2:$3"

  # coords="$(
  #   jq \
  #     --argjson dx "$2" \
  #     --argjson dy "$3" \
  #     --argjson display "$(yabai -m query --displays --window | jq -r '.frame')" \
  #     --argjson window "$(yabai -m query --windows --window | jq -r '.frame')" \
  #     -nr '(($display.x + ($display.w - $dx) / 2) - $window.x | tostring)
  #           + ":"
  #           + (($display.y + ($display.h - $dy - 25) / 2) - $window.y | tostring)'
  # )"
  # yabai -m window --resize "abs:$2:$3"
  # yabai -m window --move "rel:$coords"

  # yabai -m window --resize "abs:$2:$3"
  # . "$HOME/.config/yabai/float-center.sh"
elif [[ "$1" == "grid" ]]; then
  orientation=$(
    jq \
      --argjson frame "$(yabai -m query --displays --window | jq -r '.frame')" \
      -nr \
      '(if $frame.w > $frame.h then "landscape" else "portrait" end)'
  )
  grid=$([ "$orientation" == "landscape" ] && echo "$2" || echo "$3")
  yabai -m window --grid "$grid"
fi
