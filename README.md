# Dotfiles
- my public dotfiles

## Install
**Linux**
``` sh
git clone git@github.com:kemonprogrammer/dotfiles.git "$HOME"/.dotfiles
cd !$
bash install
```

**Windows**
``` ps1
git clone git@github.com:kemonprogrammer/dotfiles.git "$HOMEPATH\.dotfiles"
cd "$HOMEPATH\.dotfiles"
powershell.exe -ExecutionPolicy Bypass -File .\windows\scripts\setup.ps1
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

## Fonts
- Cascadia Mono link: https://github.com/microsoft/cascadia-code/releases
- Fira mono nerdfont  $ wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraMono.zip

kubectl
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"


sudo visudo
`Defaults editor=/usr/bin/nvim`
`<yourusername> ALL=(ALL) NOPASSWD: /usr/local/bin/minikube`

## CLI Programs
- Github CLI
	- https://github.com/cli/cli/blob/trunk/docs/install_linux.md


