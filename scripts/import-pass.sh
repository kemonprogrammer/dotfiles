#!/bin/bash
if [ ! -f ~/Downloads/DatabaseXC.xml ]; then 
  echo "file ~/Downloads/DatabaseXC.xml not found"
  exit 1
fi
python ~/.dotfiles/scripts/solve-references.py ~/Downloads/DatabaseXC.xml
python ~/.dotfiles/scripts/keepass2pass.py -f ~/Downloads/DatabaseXC.xml.solved.xml


