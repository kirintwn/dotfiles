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

# Add ruby plugin
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
