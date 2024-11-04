#!/usr/bin/bash

set -e

echo make soft link

src_path=$(cd "$(dirname ${BASH_SOURCE[0]} )" && pwd)/$(basename "$1")

ln -sf ${src_path}/i3_config ~/.config/i3/config
mkdir -p ~/.config/alacritty
ln -sf ${src_path}/alacritty.toml ~/.config/alacritty/alacritty.toml




