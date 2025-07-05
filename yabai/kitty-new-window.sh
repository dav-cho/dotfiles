#!/usr/bin/env bash

kitty=/Applications/kitty.app/Contents/MacOS/kitty

if pgrep -f $kitty &>/dev/null; then
	$kitty msg create-window
else
	open -a $kitty
fi

osascript -e 'tell application "kitty" to activate'
