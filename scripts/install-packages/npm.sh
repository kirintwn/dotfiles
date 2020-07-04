#!/usr/bin/env bash

# Prerequisites:
# * asdf - install from zinit
# * npm - install from asdf

export ASDF_SKIP_RESHIM=1

npm install -g npm

npm install -g pm2
npm install -g npm-check
npm install -g fx
npm install -g prettier
npm install -g neovim

asdf reshim nodejs
