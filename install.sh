#!/bin/bash

# all the apt packages that don't need special repos
apt update -y
apt install $(cat apt/packages.txt) -y

# get keys for special repos
./apt/keys.sh
# add special repos
cp apt/sources.list /etc/apt/sources.list
# install from special repos
apt update -y
apt install $(cat apt/pkgsfromrepos.txt) -y

# misc
./misc/docker-compose.sh

# pip
pip3 install -r pip/requirements.txt

# shell
cp shell/mine.zsh-theme ~/.oh-my-zsh/themes
cp shell/.zshrc ~/.zshrc