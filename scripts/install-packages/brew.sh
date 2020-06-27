#!/usr/bin/env bash

# Prerequisites:
# * Xcode - from Apple App Store
# * Homebrew - /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade

brew install zsh
# To use zsh as default shell:
# *	sudo sh -c "echo $(which zsh) >> /etc/shells" 
# *	chsh -s $(which zsh)

brew install neofetch
brew install derailed/k9s/k9s

brew tap homebrew/cask-fonts

brew cask install iterm2
brew cask install font-sourcecodepro-nerd-font
brew cask install iina

brew cleanup
