fish_vi_key_bindings
fish_config theme choose "Catppuccin Mocha"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""

# This assumes NVM plugin is installed 
set --universal nvm_default_version v22.12.0
set --universal nvm_default_packages yarn

# This assumes fzf is installed
set fzf_directory_opts --bind "ctrl-n:execute($EDITOR {} &> /dev/tty)"

# Created by `pipx` on 2025-01-03 08:42:37
set PATH $PATH /home/amjadw/.local/bin
