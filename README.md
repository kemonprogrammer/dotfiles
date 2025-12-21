todos 
- [ ] linux chrome -> get flag from .desktop file
- [ ] linux chrome rename PWAs
- [ ] auto install following programs
zoxide  $ curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
ohmyposh  $ curl -s https://ohmyposh.dev/install.sh | bash -s
fdfind  $ sudo apt-get install fd-find
ripgrep  $ sudo apt-get install ripgrep
fzf  $ sudo apt install fzf

setup neovim vim plug
``` sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# then install
neovim 
:PlugInstall
```


fonts
- Fira mono nerdfont  $ wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraMono.zip

kubectl
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"


sudo visudo
`Defaults editor=/usr/bin/nvim`
`<yourusername> ALL=(ALL) NOPASSWD: /usr/local/bin/minikube`


# Dotfiles
- my public dotfiles

## Install
``` sh
git clone git@github.com:kemonprogrammer/dotfiles.git .dotfiles
cd !$
bash install
```

# Notes
## Fonts
- FiraMono

## Custom programs
- mcd
	- [ ] TODO allow mkdir -p and then cd
- up
	- have up be included in the install script, 
	so that I have it on every system
- lsd (modern ls)

## CLI Programs
- Github CLI
	- https://github.com/cli/cli/blob/trunk/docs/install_linux.md


