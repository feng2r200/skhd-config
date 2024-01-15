#!/usr/bin/env bash

yabai_mode=$(yabai -m query --spaces --display | jq -r 'map(select(."has-focus" == true))[-1].type')

case "$yabai_mode" in
    bsp)
    yabai -m config layout stack
    ;;
    stack)
    yabai -m config layout bsp
    ;;
    float)
    yabai -m config layout bsp
    ;;
esac

sketchybar --trigger window_focus
