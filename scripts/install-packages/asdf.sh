#!/usr/bin/env bash

# Prerequisites:
# * asdf - install from zinit
# * gpg - brew install gpg

asdf update

# Add nodejs plugin
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

# Add python plugin
asdf plugin-add python

# Add lua plugin
asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git

# Add golang plugin
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git

# Add rust plugin
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
