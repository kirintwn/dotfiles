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

brew install less
brew install gnupg
brew install neofetch
brew install aws-iam-authenticator
brew install kubectl
brew install derailed/k9s/k9s
brew install tealdeer
brew install neovim
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

brew tap homebrew/cask-fonts

brew cask install amethyst
brew cask install iterm2
brew cask install font-sourcecodepro-nerd-font
brew cask install alacritty
brew cask install iina

brew install khanhas/tap/spicetify-cli

brew cleanup
