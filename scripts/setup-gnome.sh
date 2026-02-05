#!/bin/bash
DOTFILES_DIR=$(git rev-parse --show-toplevel)

echo "Setting up gnome keyboard shortcuts"
dconf load /org/gnome/desktop/wm/keybindings/ < "$DOTFILES_DIR"/gnome/window-shortcuts.dconf
dconf load /org/gnome/desktop/wm/keybindings/ < "$DOTFILES_DIR"/gnome/app-shortcuts.dconf

