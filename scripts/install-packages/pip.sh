#!/usr/bin/env bash

# Prerequisites:
# * asdf - install from zinit
# * pip - install from asdf

pip install --upgrade pip

pip install awscli
pip install glances
pip install --user neovim

asdf reshim python
