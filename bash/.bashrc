export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# Set vim as $VISUAL and $EDITOR
export VISUAL=nvim
export EDITOR="$VISUAL"
export SUDO_EDITOR="$VISUAL"


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Add custom directory variables, like ~
shopt -s cdable_vars

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
    # don't display idiotic suggestions on cd
    complete -r cd
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
    # don't display idiotic suggestions on cd
    complete -r cd
	fi
fi

# Create and change directory command
mcd () {
	mkdir -p "$1" && cd "$_";
}

stty -ixon

# --- Sourcing files

# up command instead of cd ../../../
if [ -e ~/.config/up/up.sh ]; then
	source ~/.config/up/up.sh
fi


# add bin folder to PATH
export PATH="$HOME/dotfiles/bin/:$PATH"


# Source bash aliases
if [ -e $HOME/.bash_aliases ]; then
	source $HOME/.bash_aliases
fi

# Use local bashrc if created
# bashrc_local="~/.bashrc.local" # doesn't work
if [ -f ~/.bashrc.local ]; then
	source ~/.bashrc.local 
fi


export PATH="/opt/warden/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="/mnt/c/WINDOWS:$PATH"

eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/zen.toml)"

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

# --- fzf
if [ -e /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
if [ -e /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi
if [ -e /usr/share/fzf/shell/key-bindings.bash ]; then
    source /usr/share/fzf/shell/key-bindings.bash
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# fzf for fuzzy finding file content
fzf_rg() {
    RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case"
    local selected
    selected=$(eval "$RG_PREFIX \"$1\"" | fzf --ansi --delimiter ':' \
        --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' \
        --bind 'enter:execute(nvim {1} +{2})')
    [ -n "$selected" ] && echo "$selected"
}

bind -x '"\C-f": "fzf_rg "'  # Press Ctrl+F to trigger fzf_rg

# ZSH-like Autocompletion
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# zoxide
eval "$(zoxide init --cmd cd bash)"

# auto completion
# src: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#enable-shell-autocompletion
source <(kubectl completion bash)
alias k='kubectl'
# 2. Tell Bash that 'k' should use the same logic as 'kubectl'
complete -F __start_kubectl k

alias mk=minikube

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/michael/downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/michael/downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/michael/downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/michael/downloads/google-cloud-sdk/completion.bash.inc'; fi
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

# Only set Windows-specific aliases if running in WSL
if grep -qEi "(Microsoft|WSL)" /proc/version; then
    [ -f ~/.wslrc.sh ] && source ~/.wslrc.sh
fi

export KIALI_SOURCES="~/kiali-sources"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:$HOME/.npm-global/bin"

export PATH="$PATH:$HOME/.istioctl/bin"

alias open=xdg-open
alias hist='history | head -n -1 && history -d $(history 1 | awk "{print \$1}")'

# Binds Alt+C to pipe the current line to xclip
copy_buffer_to_clipboard() {
    # For X11
    echo -n "$READLINE_LINE" | xclip -sel clip
    # For Wayland, use: echo -n "$READLINE_LINE" | wl-copy
}

# Create a Readline bind
bind -x '"\ec": copy_buffer_to_clipboard'

alias gs=""

export PATH="$PATH:/usr/local/go/bin"

# Helper function to list passwords
_fzf_pass_list() {
    # Using 'command' ensures we call the real find/sed/fzf, not an alias or function
    command find "$HOME/.password-store/" -name "*.gpg" | \
    command sed "s|.*.password-store/||;s|.gpg$||" | \
    command fzf --height 40% --reverse --border
}

# Remove a password entry
passrm() {
    local target
    target=$(_fzf_pass_list)
    
    # Check if target is empty (User pressed Esc or Ctrl+C in fzf)
    if [[ -n "$target" ]]; then
        # 'command pass' bypasses any aliases or functions named 'pass'
        command pass rm "$target"
    else
        echo "No password selected."
    fi
}

# Copy a password to clipboard
passc() {
    local target
    target=$(_fzf_pass_list)
    
    if [[ -n "$target" ]]; then
        command pass -c "$target"
    else
        echo "No password selected."
    fi
}
