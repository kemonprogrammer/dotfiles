#!/bin/bash

# 1. Define paths
LOCAL_BIN="$HOME/.local/bin"
LOCAL_APP_DIR="$HOME/.local/share/applications"
CHROME_DESKTOP="google-chrome.desktop"
WRAPPER_SCRIPT="$LOCAL_BIN/google-chrome"
DOWNLOAD_PATH="/tmp/google-chrome-stable_current_x86_64.rpm"

# 2. Install Google Chrome if not present
if ! type -p google-chrome-stable > /dev/null; then
    echo "Google Chrome not found. Downloading latest RPM..."
    curl -L -o "$DOWNLOAD_PATH" https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    
    if [ -f "$DOWNLOAD_PATH" ]; then
        echo "Installing Google Chrome..."
        sudo dnf install -y "$DOWNLOAD_PATH"
    else
        echo "Error: Failed to download Google Chrome RPM."
        exit 1
    fi
fi

# 3. Ensure directories exist
mkdir -p "$LOCAL_BIN"
mkdir -p "$LOCAL_APP_DIR"

# 4. Test wrapper script setup
if [ ! -f "$WRAPPER_SCRIPT" ]; then
    echo "No wrapper script at $WRAPPER_SCRIPT found. Setup aborted."
    exit 1
fi

chmod +x "$WRAPPER_SCRIPT"

# 5. Handle the main Chrome .desktop file
if [ ! -f "$LOCAL_APP_DIR/$CHROME_DESKTOP" ]; then
    echo "Copying system desktop file to local directory..."
    cp "/usr/share/applications/$CHROME_DESKTOP" "$LOCAL_APP_DIR/"
fi

# Update main Chrome only if it still points to /usr/bin
if grep -q "Exec=/usr/bin/google-chrome-stable" "$LOCAL_APP_DIR/$CHROME_DESKTOP"; then
    echo "Updating Exec lines in $CHROME_DESKTOP..."
    sed -i "s|Exec=/usr/bin/google-chrome-stable|Exec=$WRAPPER_SCRIPT|g" "$LOCAL_APP_DIR/$CHROME_DESKTOP"
else
    echo "Main Chrome desktop file already updated."
fi

# 6. Update all Chrome PWA desktop files
echo "---"
echo "Checking Chrome PWAs..."

for pwa in "$LOCAL_APP_DIR"/chrome-*.desktop; do
    [ -e "$pwa" ] || continue

    # Extract the first 'Name=' found for the display label
    PWA_NAME=$(grep -m 1 "^Name=" "$pwa" | cut -d'=' -f2)
    
    # Check if the file contains the target string at all
    if grep -q "/opt/google/chrome/google-chrome" "$pwa"; then
        echo "Updating PWA: $PWA_NAME"
        # Update all occurrences of the binary path in one go
        sed -i "s|/opt/google/chrome/google-chrome|$WRAPPER_SCRIPT|g" "$pwa"
    else
        echo "Skipping (Already Updated): $PWA_NAME"
    fi
done

# 7. Final Refresh
if type update-desktop-database > /dev/null 2>&1; then
    update-desktop-database "$LOCAL_APP_DIR"
fi

echo "---"
echo "Chrome setup complete!"
