#!/usr/bin/env bash

# Prerequisites:
# * asdf - install from zinit
# * gpg - brew install gpg

asdf update

# node.js
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

# python
asdf plugin-add python

# lua
asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git

# golang
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git

# rust
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
