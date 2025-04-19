#!/usr/bin/env bash

config="$HOME/dotfiles/yabai/layout/socials.json"

# jq -c '.[]' "$config" | while read -r window; do
#   id=$(echo "$window" | jq '.id')
#   x=$(echo "$window" | jq '.frame.x')
#   y=$(echo "$window" | jq '.frame.y')
#   w=$(echo "$window" | jq '.frame.w')
#   h=$(echo "$window" | jq '.frame.h')
#
#   yabai -m window "$id" --move "$x:$y" --resize "$w:$h"
# done

space=$(yabai -m query --spaces --space last | jq -r '.index')
yabai -m space --focus "$space" &>/dev/null
yabai -m config --space "$space" split_type 'horizontal' auto_balance 'on'
yabai -m space "$space" --layout 'float'
yabai -m space "$space" --layout 'bsp'

windows=$(yabai -m query --windows --space "$space")
spotify=$(echo "$windows" | jq -r '.[] | select(.app == "Spotify") | .id')
discord=$(echo "$windows" | jq -r '.[] | select(.app == "Discord") | .id')
kakao=$(echo "$windows" | jq -r '.[] | select(.app == "KakaoTalk") | .id')
messenger=$(echo "$windows" | jq -r '.[] | select(.app == "Messenger") | .id')

yabai -m window "$spotify" --swap 'first' --focus "$spotify" --focus south
yabai -m window --swap "$discord" --focus south
yabai -m window --swap "$kakao" --focus south

yabai -m config --space last split_type 'auto' auto_balance 'off'
