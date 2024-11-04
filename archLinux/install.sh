#!/usr/bin/bash

set -e

# the 1st param is instStep, default is 0
instStep=${1:-0}

# if instStep <= 0
if [ $instStep -le 0 ]; then
    # step 0
    # update pacman
    sudo pacman -Syyu --noconfirm
    sudo ln -sf /usr/bin/vim /usr/bin/vi
fi


if [ $instStep -le 1 ]; then
    # step 1
    # git & config
    sudo pacman --noconfirm -S git less
    git config --global user.name "mebusy"
    git config --global user.email "golden_slime@hotmail.com"
    git config --global pull.rebase false

    # if is linux
    git config --global credential.helper store
fi

if [ $instStep -le 2 ]; then
    # step 2
    # font & alacritty
    sudo pacman --noconfirm -S noto-fonts-cjk wqy-zenhei adobe-source-han-sans-otc-fonts
    sudo pacman --noconfirm -S alacritty picom fcitx fcitx-googlepinyin fcitx-configtool
    wget https://raw.githubusercontent.com/FortAwesome/Font-Awesome/refs/heads/4.x/fonts/fontawesome-webfont.ttf
    sudo mv -f fontawesome-webfont.ttf /usr/share/fonts/
    sudo fc-cache -fv
fi

if [ $instStep -le 3 ]; then
    sudo pacman --noconfirm -S feh
    mkdir -p ~/.wallpaper
    wget -O ~/.wallpaper/snowMountain.jpg https://github.com/dharmx/walls/blob/main/mountain/a_snowy_mountain_tops_with_a_grey_sky.jpg?raw=true
fi


# display, gtk, file explorer, dmenu->rofi, sound control
if [ $instStep -le 4 ]; then
    # lxappearance to change gtk font size / theme
    sudo pacman --noconfirm -S arandr lxappearance arc-gtk-theme thunar rofi pavucontrol
 
fi
# invoke ./i3wmConf/makeSoftLink.sh
./i3wmConf/makeSoftLink.sh


