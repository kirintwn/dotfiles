#!/usr/bin/env bash

# Prerequisites (for MacOS):
# * Xcode - from Apple App Store
# * Homebrew - /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade

# For MacOS only
brew install zsh
# To use zsh as default shell:
# *	sudo sh -c "echo $(which zsh) >> /etc/shells" 
# *	chsh -s $(which zsh)
brew install subversion
brew install less
brew install gnupg
brew install neofetch
brew install neovim
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# For Both Linux & MacOS
brew install git
brew install awscli
brew install kubernetes-cli
brew install k9s
brew install helm
brew install tealdeer
brew install croc

# Casks (for MacOS only)
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
brew install --cask appcleaner
brew install --cask amethyst
brew install --cask karabiner-elements
brew install --cask bettertouchtool
brew install --cask scroll-reverser
brew install --cask balance-lock
brew install --cask google-chrome
brew install --cask visual-studio-code
brew install --cask iterm2
brew install --cask alacritty
brew install --cask docker
brew install --cask telegram
brew install --cask spotify
brew install --cask iina
brew install --cask zoom
brew install --cask microsoft-outlook

brew cleanup
