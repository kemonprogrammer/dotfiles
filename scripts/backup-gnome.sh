#!/bin/bash
dconf dump /org/gnome/desktop/wm/keybindings/ > window-shortcuts.dconf
dconf dump /org/gnome/desktop/wm/keybindings/ > app-shortcuts.dconf
