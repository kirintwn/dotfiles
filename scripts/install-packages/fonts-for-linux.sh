#!/usr/bin/env bash

mkdir -p "$XDG_DATA_HOME"/fonts/{SourceCodePro,FiraCode}

cd "$XDG_DATA_HOME"/fonts/SourceCodePro
curl -sSL -o \
  "Sauce Code Pro Black Italic Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Black-Italic/complete/Sauce%20Code%20Pro%20Black%20Italic%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Black Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Black/complete/Sauce%20Code%20Pro%20Black%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Bold Italic Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Bold-Italic/complete/Sauce%20Code%20Pro%20Bold%20Italic%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Bold Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro ExtraLight Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Extra-Light/complete/Sauce%20Code%20Pro%20ExtraLight%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro ExtraLight Italic Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/ExtraLight-Italic/complete/Sauce%20Code%20Pro%20ExtraLight%20Italic%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Italic Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Italic/complete/Sauce%20Code%20Pro%20Italic%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Light Italic Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Light-Italic/complete/Sauce%20Code%20Pro%20Light%20Italic%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Light Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Light/complete/Sauce%20Code%20Pro%20Light%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Medium Italic Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Medium-Italic/complete/Sauce%20Code%20Pro%20Medium%20Italic%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Medium Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Medium/complete/Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Semibold Italic Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold-Italic/complete/Sauce%20Code%20Pro%20Semibold%20Italic%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Sauce Code Pro Semibold Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete.ttf

cd "$XDG_DATA_HOME"/fonts/FiraCode
curl -sSL -o \
  "Fira Code Bold Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Fira Code Light Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Fira Code Medium Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Fira Code Regular Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Fira Code Retina Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Retina/complete/Fira%20Code%20Retina%20Nerd%20Font%20Complete.ttf

curl -sSL -o \
  "Fira Code SemiBold Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/SemiBold/complete/Fira%20Code%20SemiBold%20Nerd%20Font%20Complete.ttf

echo "Please run the command to refresh font cache:"
echo "sudo fc-cache -fv"
