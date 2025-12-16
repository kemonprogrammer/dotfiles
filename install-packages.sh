#!/bin/bash

# 1. Detect the package manager
if command -v apt &> /dev/null; then
    PKM="sudo apt install -y"
elif command -v dnf &> /dev/null; then
    PKM="sudo dnf install -y"
else
    echo "Error: Neither apt nor dnf found."
    exit 1
fi

# 2. Define the package "map" (Associative Array)
# Key = Friendly Name, Value = Actual Package Name
declare -A PACKAGES
PACKAGES=(
    ["ripgrep"]="ripgrep"
    ["fd"]="fd-find"
    ["bat, cat alternative"]="bat"
)

# 3. Execute the installation by iterating over the map
echo "Updating and installing packages via ${PKM%% *}..."

for NAME in "${!PACKAGES[@]}"; do
    PACKAGE_NAME=${PACKAGES[$NAME]}
    echo "--- Installing $NAME ($PACKAGE_NAME) ---"
    $PKM "$PACKAGE_NAME"
done
