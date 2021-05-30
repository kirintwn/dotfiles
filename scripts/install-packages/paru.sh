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
paru -S telegram-desktop
paru -S spotify
paru -S flameshot
paru -S f5vpn

paru -S bat
paru -S exa
paru -S fd
paru -S ripgrep
paru -S fzf
paru -S git-delta-bin
paru -S fnm-bin
paru -S bind
paru -S traceroute
paru -S neofetch
paru -S neovim
paru -S tealdeer
paru -S aws-cli-v2-bin
paru -S kubectl
paru -S k9s
paru -S helm
