#!/bin/bash
cd ~/.dotfiles
DOTFILES_DIR=$(git rev-parse --show-toplevel)
DCONF_DIR="$DOTFILES_DIR/gnome/.config/gnome"

echo "Loading gnome keyboard shortcuts from $DCONF_DIR/*.dconf"

WINDOW_SHORTCUTS_FILE="$DCONF_DIR"/window-shortcuts.dconf
APP_SHORTCUTS_FILE="$DCONF_DIR"/app-shortcuts.dconf
if [ ! -f "$WINDOW_SHORTCUTS_FILE" ]; then 
  echo "Couldn't find file $WINDOW_SHORTCUTS_FILE"
  exit 1
fi
if [ ! -f "$APP_SHORTCUTS_FILE" ]; then 
  echo "Couldn't find file $APP_SHORTCUTS_FILE"
  exit 1
fi

dconf load /org/gnome/desktop/wm/keybindings/ < "$WINDOW_SHORTCUTS_FILE"
dconf load /org/gnome/desktop/wm/keybindings/ < "$APP_SHORTCUTS_FILE"

