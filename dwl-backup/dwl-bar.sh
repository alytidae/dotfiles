#!/bin/sh
interval=2

while :; do
    bat=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "n/a")
    temp=$(awk '{printf "%.1f", $1/1000}' /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo "n/a")

    cpu_idle_prev=$(awk '/^cpu / {print $5}' /proc/stat)
    total_prev=$(awk '/^cpu / {s=0; for (i=2;i<=NF;i++) s+=$i; print s}' /proc/stat)
    sleep 0.1
    cpu_idle_next=$(awk '/^cpu / {print $5}' /proc/stat)
    total_next=$(awk '/^cpu / {s=0; for (i=2;i<=NF;i++) s+=$i; print s}' /proc/stat)
    cpu_usage=$((100 * (total_next - total_prev - (cpu_idle_next - cpu_idle_prev)) / (total_next - total_prev)))

    mem_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    mem_available=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    mem_used=$((100 * (mem_total - mem_available) / mem_total))

    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{printf "%d%%", $2 * 100}' || echo "n/a")
    mic=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null | awk '{printf "%d%%", $2 * 100}' || echo "n/a")

    ssid=$(iw dev 2>/dev/null | awk '/ssid/ {print $2}')
    net="${ssid:-n/a}"

    time=$(date '+%H:%M')
    layout=$(swaymsg -t get_inputs | awk -F'"' '/xkb_active_layout_name/ {print $4; exit}' 2>/dev/null || echo "?")

    printf "BAT %s%% | TEMP %s°C | CPU %s%% | RAM %s%% | VOL %s | MIC %s | NET %s | LAYOUT %s | TIME %s\n" \
           "$bat" "$temp" "$cpu_usage" "$mem_used" "$vol" "$mic" "$net" "$layout" "$time"

    sleep "$interval"
done
