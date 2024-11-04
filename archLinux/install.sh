#!bash

set -e

# the 1st param is instStep, default is 0
instStep=${1:-0}




# if instStep <= 0
if [ $instStep -le 0 ]; then
    # step 0
    # update pacman
    sudo pacman -Syyu --noconfirm
fi


if [ $instStep -le 1 ]; then
    # step 1
    # git & config
    sudo pacman --noconfirm -S git less
    git config --global user.name "mebusy"
    git config --global user.email "golden_slime@hotmail.com"
    # if is linux
    if [ -f /etc/lsb-release ]; then
        git --config credential.helper store
    fi
fi

if [ $instStep -le 2 ]; then
    # step 2
    # font & alacritty
    sudo pacman --noconfirm -S noto-fonts-cjk wqy-zenhei adobe-source-han-sans-otc-fonts
    sudo pacman --noconfirm -S alacritty picom fcitx fcitx-googlepinyin fcitx-configtool
fi


