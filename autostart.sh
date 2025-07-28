#!/bin/sh
 
# Kill already running dublicate process
_ps="swaybg waybar udiskie blueman-applet pipewire pipewire-pulse kanata foot"
for _prs in $_ps; do
    if [ "$(pidof "${_prs}")" ]; then
         killall -9 "${_prs}"
    fi
 done

# Start our applications
swaybg -i ~/docs/wallpaper/rai.png &
waybar &
udiskie --automount &
blueman-applet &
pipewire &
pipewire-pulse &
kanata -c "$HOME/ws/dotfiles/kanata/kanata.kbd" &
foot --server &
