#!/usr/bin/env bash

floating=$(yabai -m query --windows --window | jq '."is-floating"')

# if [ "$floating" = "false" ]; then
#   yabai -m window --toggle float
# fi

# if [ $# - eq 0 ]; then
#   exit 0
# fi

# frame=$(yabai -m query --displays --window | jq -r '.frame')
# orientation=$(
#   jq \
#     --argjson frame "$frame" \
#     -nr \
#     '(if $frame.w > $frame.h then "landscape" else "portrait" end)'
# )

orientation=$(
  jq \
    --argjson frame "$(yabai -m query --displays --window | jq -r '.frame')" \
    -nr \
    '(if $frame.w > $frame.h then "landscape" else "portrait" end)'
)

echo $orientation

