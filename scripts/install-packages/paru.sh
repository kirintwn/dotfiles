#!/usr/bin/env bash

# Prerequisites:
# * paru -
#     sudo pacman -S base-devel
#     mkdir -p ~/Documents/resources
#     cd ~/Documents/resources/
#     git clone https://aur.archlinux.org/paru.git
#     cd paru
#     makepkg -si # choose rustup as rust provider
#     rustup default stable
#     makepkg -si
#     paru

paru -S noto-fonts-cjk
paru -S noto-fonts-emoji
paru -S nerd-fonts-fira-code
# fc-cache -fv
# reboot

paru -S fcitx5-im # all deps: fcitx5, fcitx5-configtool, fcitx5-gtk, fcitx5-qt
paru -S fcitx5-chewing
# reboot
# fcitx5-configtool

paru -S pulseaudio
paru -S pulseaudio-alsa
paru -S pulseaudio-bluetooth
paru -S pavucontrol
# reboot

paru -S google-chrome
paru -S alacritty
paru -S visual-studio-code-bin
# paru -S gnome-keyring
paru -S telegram-desktop
# curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
paru -S spotify
paru -S flameshot
paru -S f5vpn

paru -S subversion
paru -S unzip
paru -S zsh
# chsh -s $(which zsh)
paru -S bat
paru -S exa
paru -S fd
paru -S ripgrep
paru -S fzf
paru -S git-delta
paru -S fnm-bin
# fnm list-remote; fnm install vX.Y.Z; fnm default vX.Y.Z;
paru -S python
paru -S python-pip
paru -S lua
paru -S bind
paru -S traceroute
paru -S neofetch
paru -S neovim
paru -S tealdeer
paru -S aws-cli-v2-bin
paru -S kubectl
paru -S k9s
paru -S helm
paru -S docker
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# sudo systemctl enable docker
# sudo systemctl start docker
paru -S docker-compose-bin
