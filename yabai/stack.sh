#!/usr/bin/env bash

case "$1" in
west)
	yabai -m window --stack west && yabai -m window --focus stack.next
	;;
south)
	yabai -m window --stack south && yabai -m window --focus stack.next
	;;
north)
	yabai -m window --stack north && yabai -m window --focus stack.next
	;;
east)
	yabai -m window --stack east && yabai -m window --focus stack.next
	;;
prev)
	yabai -m window --stack prev && yabai -m window --focus stack.next
	;;
next)
	yabai -m window --stack next && yabai -m window --focus stack.next
	;;
recent)
	yabai -m window --stack recent && yabai -m window --focus stack.next
	;;
on-west)
	yabai -m window --focus west && yabai -m window --stack east && yabai -m window --focus stack.last
	;;
on-south)
	yabai -m window --focus south && yabai -m window --stack north && yabai -m window --focus stack.last
	;;
on-north)
	yabai -m window --focus north && yabai -m window --stack south && yabai -m window --focus stack.last
	;;
on-east)
	yabai -m window --focus east && yabai -m window --stack west && yabai -m window --focus stack.last
	;;
on-prev)
	yabai -m window --focus prev && yabai -m window --stack next && yabai -m window --focus stack.last
	;;
on-next)
	yabai -m window --focus next && yabai -m window --stack prev && yabai -m window --focus stack.last
	;;
on-recent)
	yabai -m window --focus recent && yabai -m window --stack recent && yabai -m window --focus stack.last
	;;
esac
