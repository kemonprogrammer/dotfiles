#!/bin/bash

# Configuration
SOURCE_DIR="$HOME/.config/gnome"
EXT_LIST="$SOURCE_DIR/extensions.list"
EXT_PREFS="$SOURCE_DIR/extensions-prefs.dconf"
ENABLED_FILE="$SOURCE_DIR/enabled-extensions.txt"

# Ensure gext is actually available
if ! command -v gext &> /dev/null; then
    echo "Error: 'gext' command not found. Please install it first."
    exit 1
fi

echo "--- Starting GNOME Extension Restore with gext ---"

# 1. Install missing extensions
if [ -f "$EXT_LIST" ]; then
    echo "Checking extension installations..."
    while IFS= read -r uuid || [ -n "$uuid" ]; do
        # Clean the uuid string (remove carriage returns/whitespace)
        uuid=$(echo "$uuid" | tr -d '\r' | xargs)
        
        if [ -z "$uuid" ]; then continue; fi

        # Check if the extension directory exists in local or system path
        if [ ! -d "$HOME/.local/share/gnome-shell/extensions/$uuid" ] && \
           [ ! -d "/usr/share/gnome-shell/extensions/$uuid" ]; then
            echo "  [+] Installing missing extension: $uuid"
            gext install "$uuid"
        fi
    done < "$EXT_LIST"
else
    echo "Warning: $EXT_LIST not found. Skipping installation phase."
fi

# 2. Restore individual extension settings (dconf)
if [ -f "$EXT_PREFS" ]; then
    echo "Restoring preference configurations..."
    dconf load /org/gnome/shell/extensions/ < "$EXT_PREFS"
else
    echo "Warning: $EXT_PREFS not found."
fi

# 3. Enable the specific extensions from your backup
if [ -f "$ENABLED_FILE" ]; then
    echo "Setting enabled extensions state..."
    ENABLED_LIST=$(cat "$ENABLED_FILE")
    gsettings set org.gnome.shell enabled-extensions "$ENABLED_LIST"
fi

# 4. Restore keyboard shortcuts
echo "Saving gnome window keybindings..."
dconf load /org/gnome/desktop/wm/keybindings/ < "$SOURCE_DIR/window-shortcuts.dconf"

echo "Saving gnome app keybindings..."
dconf load /org/gnome/shell/keybindings/ < "$SOURCE_DIR/app-shortcuts.dconf"

echo "Saving custom keybindings..."
dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < "$SOURCE_DIR/custom-keybindings.dconf"


echo "--- Restore Complete ---"
echo "Note: You usually need to restart GNOME Shell by logging out and back in to apply changes."
