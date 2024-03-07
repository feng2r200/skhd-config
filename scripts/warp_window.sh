#!/bin/zsh

# Direction parameter ("north", "east", "south", "west")
direction=$1

current_window_id=$(yabai -m query --windows --window | jq -r '.id')

target_window_id=$(yabai -m query --windows --window $direction | jq -r '.id')

if [[ -n $target_window_id && $target_window_id != "null" ]]; then
	yabai -m window --warp $target_window_id && yabai -m window --focus $current_window_id
else
	target_display_index=$(yabai -m query --displays --display $direction | jq -r '.index')

	if [[ $target_display_index != "null" ]]; then
		yabai -m window --display $target_display_index && yabai -m window --focus $current_window_id
	fi
fi
