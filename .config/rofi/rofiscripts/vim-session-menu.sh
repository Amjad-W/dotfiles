#!/bin/bash
# This script displays a menu of possible vim sessions
# Sessions are located in the session_dir folder and saved through vim obsession

# Ensure session directory exists, create it if not
session_dir="${SESSION_DIR:-$HOME/bin/sessions}"
if [ ! -d "$session_dir" ]; then
    notify-send -u critical "Session directory $session_dir does not exist. Creating it now."
    mkdir -p "$session_dir" || {
        notify-send "Failed to create directory $session_dir."
        exit 1
    }
fi

# Menu loop running flag
menu_running=true

# Define action codes
ACTION_DELETE=10

while $menu_running; do
    # Fetch list of sessions, excluding the file extension
    session_list=$(find "$session_dir" -type f -name "*.vim" -printf "%f\n" | sed 's/\.vim$//')

    if [ -z "$session_list" ]; then
        notify-send -u critical "No vim sessions found."
        exit 0
    fi

    # Show session names in rofi (no "Launch" or "Delete" suffix)
    selected_session=$(echo -e "$session_list" | rofi -dmenu -config "$1" -kb-custom-1 'Ctrl+Delete')

    # If the user selected nothing, exit the menu
    if [ -z "$selected_session" ]; then
        menu_running=false
    else
        session_file="$session_dir/$selected_session.vim"

        # Handle Ctrl+Delete keybinding
        if [ $? -eq $ACTION_DELETE ]; then
            # Confirm deletion with rofi (Yes/No)
            confirm=$(echo -e "Yes\nNo" | rofi -dmenu -config "$1" -p "Are you sure you want to delete '$selected_session'?")

            if [ "$confirm" == "Yes" ]; then
                rm "$session_file" && notify-send "'$selected_session' deleted."
            else
                notify-send "Deletion cancelled."
            fi
        else
            # Launch the session in nvim with alacritty
            nohup alacritty -e nvim -S "$session_file" &
            menu_running=false
        fi
    fi
done
