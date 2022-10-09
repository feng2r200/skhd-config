#!/usr/bin/env bash

yabai -m query --spaces | jq 'reverse | .[] | select((.windows | length) == 0) | .index' \
                         | xargs -I{} yabai -m space {} --destroy
