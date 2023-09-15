#!/usr/bin/env bash

floating=$(yabai -m query --windows --window | jq '."is-floating"')

if [ "$floating" = "false" ]; then
	yabai -m window --toggle float --layer below
fi

case "$1" in
-g | --grid)
	yabai -m window --grid $2
	;;
--grid=*)
	yabai -m window --grid ${1#*=}
	;;
-r | --resize)
	yabai -m window --resize $2
	;;
--resize=*)
	yabai -m window --resize ${1#*=}
	;;
esac
