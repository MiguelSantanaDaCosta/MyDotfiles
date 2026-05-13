#!/usr/bin/env bash

wallpapers_dir="$HOME/Pictures/Wallpapers"

random_wallpaper=$(find "$wallpapers_dir" -type f | shuf -n 1)

hyprctl hyprpaper wallpaper ",$random_wallpaper"
