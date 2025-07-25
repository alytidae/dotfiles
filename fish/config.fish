set -gx PATH $HOME/.cargo/bin $PATH

if test -z "$WAYLAND_DISPLAY" -a -z "$DISPLAY"
    exec dbus-run-session -- dwl -s "$HOME/ws/dotfiles/dwl/autostart.sh" <&-
end
