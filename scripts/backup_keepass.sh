#!/bin/bash

GDRIVE_DIR="$HOME/GoogleDrive"
SOURCE_DIR="$GDRIVE_DIR/Backups"
BACKUP_DIR="$HOME/.local/share/kdbx-backups"
STATE_FILE="$HOME/.local/share/kdbx-backups/.last_sync_times"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# 1. Ensure mount
if [ ! -d "$SOURCE_DIR" ]; then
    google-drive-ocamlfuse "$GDRIVE_DIR"
    sleep 2
fi

mkdir -p "$BACKUP_DIR"
touch "$STATE_FILE"

# 2. Process files
for file in "$SOURCE_DIR"/*.kdbx; do
    [ -e "$file" ] || continue
    filename=$(basename "$file")
    
    # Get the current modification time (Unix timestamp)
    current_mtime=$(stat -c %Y "$file")
    
    # Get the last recorded modification time from our state file
    last_mtime=$(grep "^$filename:" "$STATE_FILE" | cut -d: -f2)

    # 3. Compare: If current time is greater than last recorded time, back it up
    if [ -z "$last_mtime" ] || [ "$current_mtime" -gt "$last_mtime" ]; then
        echo "Change detected in $filename. Backing up..."
        cp -p "$file" "$BACKUP_DIR/${filename}_${TIMESTAMP}"
        
        # Update the state file with the new timestamp
        # Remove old entry if exists, then append new one
        sed -i "/^$filename:/d" "$STATE_FILE"
        echo "$filename:$current_mtime" >> "$STATE_FILE"
    else
        echo "$filename has not changed. Skipping."
    fi
done

# 3. Safe Cleanup, keep at least 1 backup
for base_name in $(ls "$BACKUP_DIR" | sed 's/_[0-9-]*_[0-9-]*$//' | sort -u); do
    count=$(ls -1 "$BACKUP_DIR/${base_name}"_* 2>/dev/null | wc -l)
    if [ "$count" -gt 1 ]; then
        find "$BACKUP_DIR" -name "${base_name}_*" -type f -mtime +30 -delete
    fi
done
