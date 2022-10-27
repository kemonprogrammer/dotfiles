#!/bin/bash
if [ ! -e ~/.config/up/up.sh ]; then
	curl --create-dirs -o ~/.config/up/up.sh https://raw.githubusercontent.com/shannonmoeller/up/master/up.sh
fi
