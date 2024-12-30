#!/bin/bash
# This sample script displays a menu of possible vim sessions
# Specified in the session_dir folder
# Sessions are saved thro vim obsession https://github.com/tpope/vim-obsession
# NOTE: I added a wrapper in my config to save directly to $HOME/bin/sessions
# vim.api.nvim_create_user_command("SSave", "Obsess $HOME/bin/sessions/<args>.vim", { nargs = 1 })
MENU_RUNNING=true
session_dir="$HOME/bin/sessions"
while [ $MENU_RUNNING = true ]; do
  sessions=$(find "$session_dir" -type f -name \*.vim -printf "%f\n" | sed 's/\.vim$//')
  selection="$(echo -e "$sessions" | rofi -dmenu -config "$1" -kb-custom-1 'Ctrl+Delete')"
  action=$?

  if [ -z "$selection" ]; then
    MENU_RUNNING=false
  else
    selected_file="$session_dir/$selection.vim"
    if [ $action == 10 ]; then # Delete action
      rm "$selected_file"
    else # Launch
      nohup alacritty -e nvim -S "$selected_file" &
      MENU_RUNNING=false
    fi
  fi
done
