#!/bin/bash

# Define paths relative to your home directory
DOTFILES_ROOT="$HOME/.dotfiles"
DCONF_DIR="$DOTFILES_ROOT/gnome/.config/gnome"

# Create the directory if it doesn't exist
mkdir -p "$DCONF_DIR"

echo "Saving gnome window keybindings..."
dconf dump /org/gnome/desktop/wm/keybindings/ > "$DCONF_DIR/window-shortcuts.dconf"

echo "Saving gnome app keybindings..."
dconf dump /org/gnome/shell/keybindings/ > "$DCONF_DIR/app-shortcuts.dconf"

echo "Saving extension list..."
gnome-extensions list > "$DCONF_DIR/extensions.list"

echo "Saving enabled extensions..."
gsettings get org.gnome.shell enabled-extensions > "$DCONF_DIR/enabled-extensions.txt"

echo "Saving extension settings..."
dconf dump /org/gnome/shell/extensions/ > "$DCONF_DIR/extensions-prefs.dconf"

echo "Completed Gnome backup in $DCONF_DIR"

# --- Git Logic ---

# Change directory to the dotfiles repo
cd "$DOTFILES_ROOT" || { echo "Could not find dotfiles directory"; exit 1; }

# Stage the specific gnome directory
git add "gnome/.config/gnome"

# Check if there are staged changes specifically in that path
if ! git diff --cached --quiet -- "gnome/.config/gnome"; then
    echo "Changes detected. Committing..."
    git commit -m "Update gnome configurations"
    
    echo "Pushing changes to remote..."
    git push
else
    echo "No changes in gnome configurations to commit. Nothing to push."
fi
