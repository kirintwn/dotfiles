#!/usr/bin/env bash

# Please login to 1password desktop app, and enable the SSH agent & 1password CLI integration in settings
# Please remove all conflict files in $HOME

# Component: 1password-cli
# Purpose: pull a secret file from the 1password vault
function dspull() {
  VAULT="dotfiles"
  INPUT_FILE_PATH="$1"
  mkdir -p $(dirname ${INPUT_FILE_PATH})
  touch "$INPUT_FILE_PATH"
  FILE_PATH_RELATIVE_TO_HOME=$(realpath --relative-to="$HOME" "$INPUT_FILE_PATH")
  FILE_PATH_ABSOLUTE=$(realpath "$INPUT_FILE_PATH")
  TITLE="~/$FILE_PATH_RELATIVE_TO_HOME"

  echo "Pulling $FILE_PATH_ABSOLUTE"

  if op document get "$TITLE" --vault "$VAULT" > /dev/null 2>&1; then
    rm "$FILE_PATH_ABSOLUTE"
    op document get "$TITLE" --vault "$VAULT" --output "$FILE_PATH_ABSOLUTE" --force
  else
    echo "Item with the title \"$TITLE\" does not exist in the 1password vault"
  fi
}

# Component: 1password-cli
# Purpose: pull all secret files from the 1password vault
function dspullall() {
  VAULT="dotfiles"
  TITLES=$(op document list --vault "$VAULT" --format json | jq -r '.[].title')

  echo $TITLES | while read title ; do
    FILE_PATH_ABSOLUTE="$HOME/${title#"~/"}"
    dspull "$FILE_PATH_ABSOLUTE"
  done
}

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

mkdir -p "$XDG_CONFIG_HOME"/{alacritty,aws,bat,docker,k9s,nvim,tealdeer,zsh}
mkdir -p "$XDG_DATA_HOME"/{docker-machine,go,node,nvim,zinit,zlua,zsh}
mkdir -p "$XDG_CACHE_HOME"/{tealdeer,zcompdump}

touch "$XDG_CONFIG_HOME"/aws/{config,credentials}
touch "$XDG_DATA_HOME/zlua/.zlua"
mkdir -p "$HOME/.local/bin"

if [ "$(uname -s)" == "Darwin" ]; then
  mkdir -p "$HOME/.1password"
  ln -s "$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock" "$HOME/.1password/agent.sock"
  sudo mkdir -p /opt/1password
  sudo ln -s /Applications/1Password.app/Contents/MacOS/op-ssh-sign /opt/1password/op-ssh-sign
  ln -s /usr/local/opt/openvpn/sbin/openvpn "$HOME/.local/bin/openvpn"
fi
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

dspullall

alias dotfiles="git --git-dir=$XDG_DATA_HOME/dotfiles/ --work-tree=$HOME"
git clone --bare git@github.com:kirintwn/dotfiles.git "$XDG_DATA_HOME/dotfiles"
dotfiles checkout
dotfiles config --local status.showUntrackedFiles
