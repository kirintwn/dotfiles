#!/usr/bin/env bash

# Prerequisites:
# * Homebrew - /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew upgrade

brew install coreutils
brew install git
brew install subversion
brew install less
brew install gnupg
brew install wget
brew install neofetch
brew install neovim
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install fnm
brew install python
brew install lua
brew install bat
brew install exa
brew install fd
brew install ripgrep
brew install fzf
brew install git-delta
brew install jq
brew install jless

brew install tfenv
brew install awscli
brew install kubernetes-cli
brew install k9s
brew install helm
brew install tealdeer
brew install croc
brew tap deviceinsight/packages
brew install deviceinsight/packages/kafkactl
brew install openvpn

brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
brew install --cask google-chrome
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask spotify
brew install --cask telegram
brew install --cask alacritty
brew install --cask balance-lock
brew install --cask scroll-reverser
brew install --cask karabiner-elements
brew install --cask bettertouchtool
brew install --cask yabai
brew install --cask iina
brew install --cask zoom
brew install --cask 1password
brew install --cask 1password-cli
brew cleanup
