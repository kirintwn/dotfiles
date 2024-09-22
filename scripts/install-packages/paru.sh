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

paru -S ttf-firacode-nerd
# fc-cache -fv

paru -S fcitx5-im # including all deps: fcitx5, fcitx5-configtool, fcitx5-gtk, fcitx5-qt
paru -S fcitx5-chewing
# reboot
# fcitx5-configtool

paru -S google-chrome
paru -S alacritty
paru -S visual-studio-code-bin
paru -S telegram-desktop
paru -S discord_arch_electron
paru -S spotify
paru -S flameshot

paru -S rsync
paru -S subversion
paru -S zsh
# chsh -s $(which zsh)
paru -S bat
paru -S eza
paru -S fd
paru -S ripgrep
paru -S fzf
paru -S git-delta
paru -S jless
paru -S fnm-bin
# fnm list-remote
# fnm install vX.Y.Z
# fnm default vX.Y.Z
paru -S python-pip
paru -S lua

paru -S neovim
# git clone https://github.com/LazyVim/starter ~/.config/nvim

paru -S tfenv
paru -S aws-cli-v2
paru -S kubectl
paru -S k9s
paru -S helm
paru -S kafkactl
paru -S docker
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# sudo systemctl enable docker
# sudo systemctl start docker
# docker ps
paru -S docker-compose
# docker compose version
paru -S docker-buildx
paru -S chamber
paru -S trivy
paru -S earthly-bin

paru -S htop
paru -S neofetch
paru -S dmidecode
paru -S bind
paru -S traceroute
paru -S tealdeer
paru -S croc

paru -S openvpn
paru -S openvpn3

paru -S xclip
paru -S gnome-keyring
# ref: https://wiki.archlinux.org/title/GNOME/Keyring#PAM_step
# edit the PAM config file: /etc/pam.d/login
#   add "auth       optional     pam_gnome_keyring.so"            at the end of the auth section
#   add "session    optional     pam_gnome_keyring.so auto_start" at the end of the session section
# may need to reboot once or twice, check if 1password 2FA and VSCode sign-in works

paru -S 1password
paru -S 1password-cli

paru -S picom
paru -S blueman
