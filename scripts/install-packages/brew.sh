#!/usr/bin/env bash

# Prerequisites:
# * Xcode - from Apple App Store
# * Homebrew - /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade

# For MacOS only
brew install zsh
# To use zsh as default shell:
# *	sudo sh -c "echo $(which zsh) >> /etc/shells" 
# *	chsh -s $(which zsh)
brew install git
brew install subversion
brew install less
brew install gnupg
brew install neofetch
brew install neovim
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# For Both Linux & MacOS
brew install awscli
brew install kubectl
brew install k9s
brew install tealdeer
brew install croc

# Casks (for MacOS only)
brew tap homebrew/cask-fonts
brew cask install font-fira-code-nerd-font
brew cask install appcleaner
brew cask install amethyst
brew cask install karabiner-elements
brew cask install bettertouchtool
brew cask install scroll-reverser
brew cask install balance-lock
brew cask install firefox
brew cask install visual-studio-code
brew cask install iterm2
brew cask install alacritty
brew cask install docker
brew cask install telegram
brew cask install spotify
brew cask install iina
brew cask install zoomus
brew cask install microsoft-outlook

brew cleanup
