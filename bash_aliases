
# --- Aliases --- 
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lla="ls -la";

# git abbreviation
alias g="git";

# vim abbreviation
alias v="vim";

# Windows explorer
# Only set Windows-specific aliases if running in WSL
if grep -qEi "(Microsoft|WSL)" /proc/version; then
    [ -f ~/.wslrc.sh ] && source ~/.wslrc.sh
fi

if [ -f ~/.bash_aliases.local ]; then
	source ~/.bash_aliases.local
fi
