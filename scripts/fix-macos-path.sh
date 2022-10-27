#!/usr/bin/env bash

mkdir -p $HOME/.1password
ln -s $HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock $HOME/.1password/agent.sock

sudo mkdir -p /opt/1password
sudo ln -s /Applications/1Password.app/Contents/MacOS/op-ssh-sign /opt/1password/op-ssh-sign

ln -s /usr/local/opt/openvpn/sbin/openvpn $HOME/.local/bin/openvpn
