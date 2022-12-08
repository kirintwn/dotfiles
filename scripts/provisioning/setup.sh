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

# please login to 1password desktop app first, and enable the SSH agent in settings
if [ "$(uname -s)" == "Darwin" ]; then
  mkdir -p "$HOME/.1password"
  ln -s "$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock" "$HOME/.1password/agent.sock"
  sudo mkdir -p /opt/1password
  sudo ln -s /Applications/1Password.app/Contents/MacOS/op-ssh-sign /opt/1password/op-ssh-sign
  ln -s /usr/local/opt/openvpn/sbin/openvpn "$HOME/.local/bin/openvpn"
fi
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

alias dotfiles="git --git-dir=$XDG_DATA_HOME/dotfiles/ --work-tree=$HOME"
git clone --bare git@github.com:kirintwn/dotfiles.git "$XDG_DATA_HOME/dotfiles"

# please remove all conflict files in $HOME before running dotfiles checkout
dotfiles checkout
dotfiles config --local status.showUntrackedFiles
