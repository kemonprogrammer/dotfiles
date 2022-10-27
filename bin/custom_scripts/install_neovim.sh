#!/bin/bash

# cancel if neovim already installed
if [ $(apt list --installed &> | grep "neovim" | wc -l) -ne 0 ]; then 
	echo "Neovim is already installed" 
	exit 0;
fi

mkdir -p ~/Downloads/

# Download the file if it doesn't exist in ~/Downloads yet
if [ $(ls -l ~/Downloads/ | grep "nvim-linux64.deb" | wc -l) -eq 0 ]; then
	wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb
	mv nvim-linux64.deb ~/Downloads
fi

# Install neovim
sudo apt install ~/Downloads/nvim-linux64.deb


