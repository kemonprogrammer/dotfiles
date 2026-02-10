
sudo dnf install -y \
  xclip \
  zoxide \
  oh-my-posh \
  fd \
  bat \
  python3 \
  python3-pip \
  browserpass \

flatpak install -y flathub org.localsend.localsend_app

pip3 install --upgrade gnome-extensions-cli

flatpak install -y flathub app/io.missioncenter.MissionCenter/x86_64/stable
