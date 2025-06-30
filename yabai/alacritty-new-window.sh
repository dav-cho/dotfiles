#!/usr/bin/env bash

alacritty=/Applications/Alacritty.app/Contents/MacOS/alacritty

if pgrep -f $alacritty &>/dev/null; then
	$alacritty msg create-window
else
	open -a $alacritty
fi

osascript -e 'tell application "Alacritty" to activate'
