#!/bin/bash

# options to be displayed
option0="1. Screen"
option1="2. Area"
option2="3. Window"

# options to be displyed
options="$option0\n$option1\n$option2"

selected="$(echo -e "$options" | rofi -lines 3 -dmenu -p "󰹑 Screenshot")"
output_folder=~/Pictures/scrots/

handle_selected() {
    case $selected in
    "$option0")
        sleep 0.2 &&
            scrot -e 'xclip -selection clipboard -t image/png -i $f'
        ;;
    "$option1")
        scrot -s -e 'xclip -selection clipboard -t image/png -i $f'
        ;;
    "$option2")
        sleep 0.2 &&
            scrot -u -e 'xclip -selection clipboard -t image/png -i $f'
        ;;
    esac
}

if [ -n "$selected" ]; then
    mkdir -p "$output_folder" && cd "$output_folder" || return
    handle_selected
    notify-send "Screenshot saved to $output_folder"
fi
