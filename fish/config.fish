set -gx PATH $HOME/.cargo/bin $PATH

if test -z "$WAYLAND_DISPLAY" -a -z "$DISPLAY"
    ~/ws/dotfiles/dwl/dwl-bar.sh | dbus-run-session -- dwl -s "$HOME/ws/dotfiles/dwl/autostart.sh" <&-
end
