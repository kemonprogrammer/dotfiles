#!/bin/bash

sudo dnf install neovim -y
# todo save in dotfiles

VIM_PLUG_PATH="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
# install vim plug 
if [ ! -f "$VIM_PLUG_PATH" ]; then
  sh -c 'curl -fLo "$VIM_PLUG_PATH" --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
nvim +'PlugInstall --sync' +qa
