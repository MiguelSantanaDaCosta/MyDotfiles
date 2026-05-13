s#!/usr/bin/env bash

wallpapers_dir="$HOME/Pictures/Wallpapers"

selected_wallpaper=$(for a in "$wallpapers_dir"/*; do
    echo "$(basename "$a")"
done | rofi -dmenu -p "Wallpaper")

full_path="$wallpapers_dir/$selected_wallpaper"

hyprctl hyprpaper wallpaper ",$full_path".sh
