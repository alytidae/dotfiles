#!/bin/sh

swaybg -i ~/Downloads/wp6405945-2135845896.png &
udiskie --automount &
blueman-applet &
pipewire & disown
pipewire-pulse & disown
kanata -c "$HOME/ws/dotfiles/kanata/kanata.kbd" &


