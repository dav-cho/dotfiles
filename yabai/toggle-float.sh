#!/usr/bin/env bash

if [ "$(yabai -m query --windows --window | jq '."is-floating"')" = "false" ]; then
  yabai -m window --toggle float
fi

if [ $# -eq 0 ]; then
  exit 0
fi

orientation=$(
  jq \
    --argjson frame "$(yabai -m query --displays --window | jq -r '.frame')" \
    -nr \
    '(if $frame.w > $frame.h then "landscape" else "portrait" end)'
)
grid=$([ "$orientation" == "landscape" ] && echo "$1" || echo "$2")

yabai -m window --grid "$grid"
