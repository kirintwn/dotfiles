#!/usr/bin/env bash

# Prerequisites:
# * asdf - install from zinit
# * pip - install from asdf

pip install --upgrade pip

pip install --user --upgrade awscli
pip install --user --upgrade glances
pip install --user --upgrade neovim

asdf reshim python
