# Download
TARGET="$HOME/.local/bin/obsidian"

if [ ! -f "$TARGET" ]; then
	curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
	| grep "browser_download_url.*AppImage" \
	| grep -v "arm64" \
	| cut -d '"' -f 4 \
	| xargs curl -L -o Obsidian.AppImage

	# Setup
	mkdir -p ~/.local/bin
	mv Obsidian.AppImage ~/.local/bin/obsidian
	chmod +x ~/.local/bin/obsidian
else
	echo "Obsidian already installed at $TARGET"
fi

ICON_SOURCE=./obsidian-icon.png
ICON_TARGET=~/.local/share/icons/obsidian.png 
if [ ! -f "$ICON_TARGET" ]; then
	# Setup icon
	mkdir -p ~/.local/share/icons
	cp "$ICON_SOURCE" "$ICON_TARGET"
fi

DESKTOP_TARGET=~/.local/share/applications/obsidian.desktop
if [ ! -f "$DESKTOP_TARGET" ]; then
	# Create desktop entry
cat <<EOF > ~/.local/share/applications/obsidian.desktop
[Desktop Entry]
Name=Obsidian
Exec=$HOME/.local/bin/obsidian %u
Icon=obsidian
Type=Application
Terminal=false
Categories=Office;TextEditor;Utility;
MimeType=x-scheme-handler/obsidian;
EOF
fi

update-desktop-database ~/.local/share/applications
