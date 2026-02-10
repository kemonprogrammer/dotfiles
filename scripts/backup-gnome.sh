#!/bin/bash
cd ~/.dotfiles
DOTFILES_DIR=$(git rev-parse --show-toplevel)
DCONF_DIR="~/.config/gnome"

mkdir -p "$DCONF_DIR"

echo "Saving gnome window keybindings to $DCONF_DIR/window-shortcuts.dconf"
dconf dump /org/gnome/desktop/wm/keybindings/ > $DCONF_DIR/window-shortcuts.dconf

echo "Saving gnome app keybindings to $DCONF_DIR/app-shortcuts.dconf"
dconf dump /org/gnome/shell/keybindings/ > $DCONF_DIR/app-shortcuts.dconf
