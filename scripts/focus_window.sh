#!/bin/zsh

# args（"north", "east", "south", "west"）
direction=$1

if [[ -n $(yabai -m query --windows --window "$direction" | jq -r 'select(.id != null)') ]]; then
	yabai -m window --focus $direction
else
	if [[ $direction == "west" || $direction == "north" ]]; then
		display_direction="prev"
	else
		display_direction="next"
	fi

  target_display_index=$(yabai -m query --displays --display $display_direction | jq '.index')
  target_window_id=$(yabai -m query --windows --display $target_display_index | jq 'map(select(."is-minimized" == false and ."is-hidden" == false and ."is-floating" == false)) | .[0] | .id')

	if [[ -n $target_window_id ]]; then
		yabai -m window --focus $target_window_id
	fi
fi
