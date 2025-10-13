set -gx PATH $HOME/.cargo/bin $PATH
# set -x XDG_CURRENT_DESKTOP wlroots
# set -x XDG_SESSION_TYPE wayland
# set -x XDG_SESSION_DESKTOP wlroots

if test (tty) = /dev/tty1
    exec dbus-run-session startplasma-wayland
end

# if test -z "$WAYLAND_DISPLAY" -a -z "$DISPLAY"
# dbus-run-session -- dwl -s "$HOME/ws/dotfiles/autostart.sh" <&-
# end
