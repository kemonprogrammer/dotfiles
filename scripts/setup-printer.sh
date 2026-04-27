#!/bin/bash

# Define variables
URL="https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.6-0.gz"
FILE_GZ="linux-brprinter-installer-2.2.6-0.gz"
FILE_BIN="linux-brprinter-installer-2.2.6-0"

echo "Step 1: Downloading the Brother DCP-J315W printer installer..."
curl -L "$URL" -o "$FILE_GZ"

echo "Step 2: Decompressing the file..."
# -d decompresses, -f forces overwrite if it exists
gunzip -df "$FILE_GZ"

echo "Step 3: Setting executable permissions..."
chmod +x "$FILE_BIN"

echo "Step 4: Running the installer with sudo..."
# This will prompt for your password
sudo ./"$FILE_BIN"

echo "Printer setup complete."
