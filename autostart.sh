#!/bin/sh
# killall -9 udiskie kanata foot pipewire pipewire-pulse 
killall -9 kanata foot pipewire pipewire-pulse 
#udiskie --automount &
pipewire &
pipewire-pulse &
kanata -c "$HOME/ws/dotfiles/kanata/kanata.kbd" &
foot --server &
