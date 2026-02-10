#!/bin/bash

# Define paths relative to your home directory
DOTFILES_ROOT="$HOME/.dotfiles"
SOURCE_DIR="$DOTFILES_ROOT/gnome/.config/gnome"

# Create the directory if it doesn't exist
mkdir -p "$SOURCE_DIR"

echo "Saving gnome window keybindings..."
dconf dump /org/gnome/desktop/wm/keybindings/ > "$SOURCE_DIR/window-shortcuts.dconf"

echo "Saving gnome app keybindings..."
dconf dump /org/gnome/shell/keybindings/ > "$SOURCE_DIR/app-shortcuts.dconf"

echo "Saving extension list..."
gnome-extensions list > "$SOURCE_DIR/extensions.list"

echo "Saving enabled extensions..."
gsettings get org.gnome.shell enabled-extensions > "$SOURCE_DIR/enabled-extensions.txt"

echo "Saving extension settings..."
dconf dump /org/gnome/shell/extensions/ > "$SOURCE_DIR/extensions-prefs.dconf"

echo "Saving custom keybindings..."
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > "$SOURCE_DIR/custom-keybindings.dconf"

echo "Completed Gnome backup in $SOURCE_DIR"

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
