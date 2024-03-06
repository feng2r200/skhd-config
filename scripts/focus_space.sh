#!/bin/zsh

# 方向参数（"next", "prev"）
direction=$1

# 获取当前显示器的索引
current_display_index=$(yabai -m query --displays --display | jq '.index')

# 获取当前空间的索引
current_space_index=$(yabai -m query --spaces --space | jq '.index')

# 获取相应方向上的空间索引
if [[ $direction == "next" ]]; then
    target_space_index=$(yabai -m query --spaces --display $current_display_index | jq --arg idx $current_space_index 'map(select(.index > ($idx | tonumber)))[0].index')
else
    target_space_index=$(yabai -m query --spaces --display $current_display_index | jq --arg idx $current_space_index 'map(select(.index < ($idx | tonumber))) | last | .index')
fi

# 如果存在目标空间，则将焦点移动到该空间
if [[ -n $target_space_index && $target_space_index != "null" ]]; then
    yabai -m space --focus $target_space_index

    # 获取目标空间下相应方向上的窗口
    target_window_id=$(yabai -m query --windows --space $target_space_index | jq 'map(select(."is-minimized" == false and ."is-hidden" == false and ."is-floating" == false)) | .[0] | .id')

    # 如果存在目标窗口，则将焦点移动到该窗口
    if [[ -n $target_window_id ]]; then
        yabai -m window --focus $target_window_id
    fi
fi
