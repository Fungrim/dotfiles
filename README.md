# Fungrim Home

The homes are setup with the following: 

- Nevim config
- ZSH and Zinit with config and plugins
- YADM as the manager

## Preprequisites

You need to run the following if the machine is blank: 

```
sudo apt-get install git zsh nvim yadm
```

Then install Nerdfonts: 

```
mkdir ~/.local/share/fonts
curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monaspace.tar.xz | tar -xJf - -C ~/.local/share/fonts
fc-cache -f -v
```

Finally change shell - `chsh -s /bin/zsh` - and then log out/in. 

## Bootstrap

```
yadm clone git@github.com:Fungrim/dotfiles.git
```



