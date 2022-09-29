#!/usr/bin/env bash

layout=$(yabai -m query --spaces --space | jq '.type')
if [ $layout == '"bsp"' ];then 
  yabai -m space --layout float &> /dev/null
else
  yabai -m space --layout bsp &> /dev/null
fi
