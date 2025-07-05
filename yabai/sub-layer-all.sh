#!/usr/bin/env bash

for win_id in $(yabai -m query --windows --space | jq 'map(.id)[]'); do
	yabai -m window $win_id --sub-layer $1
done
