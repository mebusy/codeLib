#!bash

set -e

# update pacman
sudo pacman -Syyu --noconfirm

# git & config
sudo pacman --noconfirm -Sy git less
git config --global user.name "mebusy"
git config --global user.email "golden_slime@hotmail.com"
# linux only
git config credential.helper store


