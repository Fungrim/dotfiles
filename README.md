# Fungrim Home

This is a YADM repo to setup Fungrim's personal machines. 

- Neovim config
- ZSH and Zinit with config and plugins
- YADM as the manager
- Personal scripts, keys and aliases

## Preprequisites

You need to run the following if the machine is blank: 

```
sudo apt-get install git zsh nvim yadm
```

Then you also need the gitbuh CLI: https://cli.github.com/

Then install Nerdfonts: 

```
mkdir ~/.local/share/fonts
curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monaspace.tar.xz | tar -xJf - -C ~/.local/share/fonts
fc-cache -f -v
```

Update the terminal preferences, create a new profile, set as default and change fonds to the monaspace, 11pt. 

Finally change shell with `chsh -s /bin/zsh` and then log out/in. 

## Bootstrap

Make sure `https://github.com/Fungrim/dotfiles` is public, since you cannot bootstrap before the SSH keys are created. 

```
yadm clone https://github.com/Fungrim/dotfiles.git
```

Decrypt:

```
yadm decrypt
```

Check yadm status: 

```
yadm status
```

When clean, start new terminal window and go through th p10k bootstrap.

## Cleanup

Check that `~/bin` and `~/.local/bin` are clean. And remove any old SSH keys. 

Move yadm to git: 

```
yadm remote set-url origin git@github.com:Fungrim/dotfiles.git
```

Copy new SSH keys to GitHub. Install GitHub CLI. And then: 

```
sdc personal
```

Install Tailscale: 

```
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
sudo tailscale set --operator=$USER
tailscale set --accept-routes
```

Then, also install: `gh`, `sdk`, `gcloud` and `nvm`. 
