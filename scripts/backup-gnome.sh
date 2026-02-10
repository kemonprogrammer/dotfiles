#!/bin/bash
DCONF_DIR=~/.config/gnome

mkdir -p "$DCONF_DIR"

echo "Saving gnome window keybindings to $DCONF_DIR/window-shortcuts.dconf ..."
dconf dump /org/gnome/desktop/wm/keybindings/ > "$DCONF_DIR"/window-shortcuts.dconf

echo "Saving gnome app keybindings to $DCONF_DIR/app-shortcuts.dconf ..."
dconf dump /org/gnome/shell/keybindings/ > "$DCONF_DIR"/app-shortcuts.dconf

echo "Saving extension list..."
gnome-extensions list > "$DCONF_DIR/extensions.list"

echo "Saving enabled extensions..."
gsettings get org.gnome.shell enabled-extensions > "$DCONF_DIR/enabled-extensions.txt"

echo "Saving extension settings..."
dconf dump /org/gnome/shell/extensions/ > "$DCONF_DIR/extensions-prefs.dconf"

echo "Completed Gnome backup in $DCONF_DIR"
