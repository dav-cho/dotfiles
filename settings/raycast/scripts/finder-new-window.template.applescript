#!/usr/bin/osascript

# Dependency: requires Finder (https://iterm2.com)
# Install via Homebrew: `brew install --cask iterm2`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Window
# @raycast.mode fullOutput
# @raycast.packageName Finder

# Optional parameters:
# @raycast.icon ~/dav/dav-antonio-black.ico

# Documentation
# @raycast.author dav

-- Set this property to true to open in a new window instead of a new tab
property open_in_new_window : true

-- Handlers
on new_window()
	tell application "Finder" to create window
end new_window

on new_tab()
	tell application "Finder" to tell the first window to create tab
end new_tab

on call_forward()
	tell application "Finder" to activate
end call_forward

on is_running()
	application "Finder" is running
end is_running

on has_windows()
	if not is_running() then return false
	if windows of application "Finder" is {} then return false
	true
end has_windows

-- Main
on run
	if has_windows() then
    if open_in_new_window then
      new_window()
    else
      new_tab()
    end if
	else
		-- If Finder is not running and we tell it to create a new window, we get two
		-- One from opening the application, and the other from the command
		if is_running() then
			new_window()
		else
			call_forward()
		end if
	end if

	-- Make sure a window exists before we continue, or the write may fail
	repeat until has_windows()
		delay 0.01
	end repeat

	call_forward()
end run
