#!/usr/bin/env bash

window=$(yabai -m query --windows --window | jq -r '.frame')
display=$(yabai -m query --displays --window | jq -r '.frame')
coords="$(
    jq \
        --argjson window "${window}" \
        --argjson display "${display}" \
        -nr '($display.x + ($display.w - $window.w) / 2 | tostring)
            + ":"
            + ($display.y + ($display.h - $window.h - 25) / 2 | tostring)'
)"

yabai -m window --move "abs:${coords}"
