#!/usr/bin/env bash

read id is_sticky <<<$(yabai -m query --windows --window | jq -r '.id, ."is-sticky"')
if [[ $is_sticky = true ]]; then
  yabai -m window --toggle sticky
  yabai -m window --sub-layer auto
  yabai -m window $id --opacity 0.1 && sleep 0.01 && yabai -m window $id --opacity 0.0
  exit 0
fi

WIDTH=1000
HEIGHT=700

read w h <<<$(yabai -m query --displays --window | jq -r '(.frame.w | floor), (.frame.h | floor)')
padding=$(yabai -m config top_padding)
x=$((w - WIDTH - padding))
y=$((padding + 25))

if [[ "$(yabai -m query --windows --window | jq '."is-floating"')" = false ]]; then
  yabai -m window --toggle float
fi

yabai -m window --move abs:$x:$y
yabai -m window --resize abs:$WIDTH:$HEIGHT
yabai -m window --toggle sticky
yabai -m window --sub-layer above
