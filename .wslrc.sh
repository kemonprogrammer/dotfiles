# Only set Windows-specific aliases if running in WSL
if grep -qEi "(Microsoft|WSL)" /proc/version; then
    alias xclip="clip.exe"
fi

exp() {
    # If no argument is provided, default to the current directory (.)
    explorer.exe "$(wslpath -w "${1:-.}")"
}

