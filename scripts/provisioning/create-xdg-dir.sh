#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

mkdir -p "$XDG_CONFIG_HOME"/{alacritty,aws,bat,docker,k9s,nvim,tealdeer,zsh}
mkdir -p "$XDG_DATA_HOME"/{docker-machine,go,node,nvim,zinit,zlua,zsh}
mkdir -p "$XDG_CACHE_HOME"/{tealdeer,zcompdump}

touch "$XDG_CONFIG_HOME"/aws/{config,credentials}
touch "$XDG_DATA_HOME/zlua/.zlua"
mkdir -p "$HOME/.local/bin"
