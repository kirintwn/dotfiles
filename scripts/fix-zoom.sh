#!/usr/bin/env bash
sed -i -E 's/userEmailAddress=.*/userEmailAddress=kirin@xendit.co/' ~/.config/zoomus.conf

if cat ~/.config/zoomus.conf | grep 'embeddedBrowserForSSOLogin='; then
  sed -i -E 's/embeddedBrowserForSSOLogin=.*/embeddedBrowserForSSOLogin=false/' ~/.config/zoomus.conf
else
  sed -i -E 's/enable.host.auto.grab=true/embeddedBrowserForSSOLogin=false\nenable.host.auto.grab=true/' ~/.config/zoomus.conf
fi
