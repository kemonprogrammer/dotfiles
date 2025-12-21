# Only set Windows-specific aliases if running in WSL
if grep -qEi "(Microsoft|WSL)" /proc/version; then
    alias exp="explorer.exe"
    alias xclip="clip.exe"
fi
