#!/bin/bash

# curl latest rpm package
https://launchpad.net/veracrypt/trunk/1.26.24/+download/veracrypt-1.26.24-Fedora-40-x86_64.rpm

# Needed?
#sudo dnf install gdk-pixbuf2-modules-extra

# Convert xpm to png for wayland
sudo dnf install -y ImageMagick
sudo magick /usr/share/pixmaps/veracrypt.xpm /usr/share/pixmaps/veracrypt.png

# sudo sed 
/usr/share/applications/veracrypt.desktop
# replace ^Icon=.* with Icon=/usr/share/pixmaps/veracrypt.png

update-desktop-database ~/.local/share/applications
