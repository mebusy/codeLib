#!/usr/bin/bash

set -e

# TIPs
# 1. change network setting, to take effect
#    systemctl restart NetworkManager


# the 1st param is instStep, default is 0
instStep=${1:-0}

i3wm=false
# if i3wm is installed
if [ -x "$(command -v i3)" ]; then
    i3wm=true
fi

# if instStep <= 0
if [ $instStep -le 0 ]; then
    # step 0
    # update pacman
    sudo pacman -Syyu --noconfirm
    sudo ln -sf /usr/bin/vim /usr/bin/vi

    # if i3wm is installed
    if [ $i3wm = true ]; then
        # create initial user folders
        sudo pacman --noconfirm -S xdg-user-dirs xss-lock
        xdg-user-dirs-update
    fi
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

if [ $instStep -le 2 ] && [ $i3wm = true ]; then
    # step 2
    # font & alacritty
    sudo pacman --noconfirm -S noto-fonts-cjk wqy-zenhei adobe-source-han-sans-otc-fonts
    sudo pacman --noconfirm -S alacritty picom fcitx fcitx-googlepinyin fcitx-configtool
    wget https://raw.githubusercontent.com/FortAwesome/Font-Awesome/refs/heads/4.x/fonts/fontawesome-webfont.ttf
    sudo mv -f fontawesome-webfont.ttf /usr/share/fonts/
    sudo cp -f -R YosemiteSanFranciscoFont /usr/share/fonts/myFonts
    sudo fc-cache -fv
fi

if [ $instStep -le 3 ] && [ $i3wm = true ]; then
    sudo pacman --noconfirm -S feh
    mkdir -p ~/.wallpaper
    wget -O ~/.wallpaper/snowMountain.jpg https://github.com/dharmx/walls/blob/main/mountain/a_snowy_mountain_tops_with_a_grey_sky.jpg?raw=true
fi


# display, gtk, file explorer, dmenu->rofi, sound control
if [ $instStep -le 4 ]; then
    # lxappearance to change gtk font size / theme
    if [ $i3wm = true ]; then
        sudo pacman --noconfirm -S arandr lxappearance arc-gtk-theme thunar rofi pavucontrol
    fi

    sudo pacman --noconfirm -S neofetch
    neofetch
fi

if [ $i3wm = true ]; then
    # invoke ./i3wmConf/makeSoftLink.sh
    ./i3wmConf/makeSoftLink.sh
fi

if [ $instStep -le 5 ]; then
    # install paru

    # if rust is not installed
    if [ ! -x "$(command -v rustup)" ]; then
        # rustup default stable
        echo 1 | curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        # should remove pre-installed rustup ?
        # sudo pacman --noconfirm -S rustup
    fi
 
    # if paru is not installed
    if [ ! -x "$(command -v paru)" ]; then
        echo install paru...
        ( rm -rf paru && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si  )
    fi

    if [ $i3wm = true ]; then
        echo 1 | paru --skipreview gtk-theme-macos-mojave
    fi
fi

if [ $instStep -le 6 ]; then
    # dev tools
    sudo pacman --noconfirm -S cmake go typescript mono lsof
fi

if [ $instStep -le 7 ]; then
    # nvm, will modify ~/.bashrc
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm install 18
    nvm use 18
fi

# re-source
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if [ $instStep -le 8 ]; then
    # java
    sudo pacman --noconfirm -S jdk8-openjdk jdk17-openjdk java-runtime-common
    # set 17 as default version
    sudo archlinux-java set java-17-openjdk
    java -version
fi

if [ $instStep -le 9 ]; then
    # python
    sudo pacman --noconfirm -S pyenv tk
    pyenv install 3.12
    pyenv global 3.12
    pyenv exec pip  install --upgrade pip
fi

export PATH="$HOME/.pyenv/shims":$PATH
export PATH=`pyenv prefix`/bin:$PATH
echo ! PYTHON version: `which python`

if [ $instStep -le 10 ]; then
    # oh-my-zsh
    if [ ! -d "$HOME/.oh-my-zsh" ];
    then
        sudo pacman --noconfirm -S zsh
        echo install oh-my-zsh...
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
fi

if [ $instStep -le 11 ]; then
    # powerlevel10k
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ];
    then
        echo install powerlevel10k...
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
            ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    fi

    
    as_path=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    if [ ! -d $as_path ];
    then
        echo install zsh-autosugestions
        git clone https://github.com/zsh-users/zsh-autosuggestions  $as_path
    fi
fi

if [ $instStep -le 12 ]; then
    # vim
    sudo pacman --noconfirm -R vim
    sudo pacman --noconfirm -S tmux gvim yarn ctags  flake8 eslint prettier stylua cpplint luacheck python-pylint
    echo 1 | paru --skipreview gotags
    echo 1 | paru --skipreview clang-format-all-git
    paru --skipreview python-black  # can not 'echo 1 | ... ' dunno why
    echo 1 | paru --skipreview tlrc
    pyenv exec pip  install setuptools # for YCMD
fi

if [ $instStep -le 13 ]; then
    ( cd ../working_settings && sh makesoftlink.sh ) 
    ( cd ../working_editor_configs && sh makesoftlink_ed.sh ) 

    vim +PlugInstall +qall
fi

if [ $instStep -le 14 ]; then
( cd ~/.vim/plugged/YouCompleteMe && ./install.py --all && rm -rf third_party/ycmd/third_party/tern_runtime/node_modules )
fi

if [ $instStep -le 15 ]; then
    ( cd ~/.vim/plugged/vimspector && ./install_gadget.py --all )
fi
if [ $instStep -le 16 ]; then
    if [ -n "$http_proxy" ]; then
        ( cd ~/.vim/plugged/vim-prettier && rm yarn.lock && yarn install --frozen-lockfile --production && git checkout . )
    else
        ( cd ~/.vim/plugged/vim-prettier && yarn install --frozen-lockfile --production )
    fi
fi

if [ $instStep -le 20 ]; then
    # if docker not installed, intall it
    if [ ! -x "$(command -v docker)" ]; then
        sudo pacman --noconfirm -S docker
    fi

    sudo systemctl enable docker
    sudo systemctl start docker

    sudo usermod -aG docker $USER
    newgrp docker # to make the group change effective without logout

    # docker can use proxy setting in the environment variables
    # if registry mirror  is needed
    # vi /etc/docker/daemon.json  (create if not exists yet)
    # {
    #   "registry-mirrors": [
    #     "https://docker.m.daocloud.io",
    #     "https://dockerproxy.com",
    #     "https://docker.nju.edu.cn",
    #     "https://docker.mirrors.ustc.edu.cn"
    #   ]
    # }
    # systemctl restart docker
    # `docker info`  to check
    docker --version
fi


if [ $instStep -le 21 ]; then
    # software: mail / file merge
    echo 1 | paru --skipreview sublime-text-4
    sudo pacman -S --noconfirm  thunderbird meld 
fi

if [ $instStep -le 22 ]; then
    sudo pacman -Syyu --noconfirm

    sudo pacman -S --noconfirm  minikube kubectl
    # minikube start [--listen-address=0.0.0.0]
    minikube start
    # # if you use a proxy, ensure you added proxy IP to no_proxy

    # minikube note:
    # 1. if you not provide --listen-address='0.0.0.0' 
    #   - `docker ps` to checkout cluster info
    #   - vi ~/.kube/config, change the ip to same one which docker container exposed
    # 2. docker port minikube  # checking  host -> container mapping port
    # 3. if you entirely in trouble, try `minikube delete --all --purge`
    # 4. `kubectl get node -v10`  may help if you are under proxy
fi

if [ $instStep -le 23 ]; then
    sudo pacman --noconfirm -S gimp libreoffice-fresh  vlc
    if [ $i3wm = true ]; then
        sudo pacman --noconfirm -S adobe-source-sans-pro-fonts languagetool
    fi
fi

if [ $instStep -le 24 ] && [ $i3wm = true ]; then
    # bluetooth
    sudo pacman --noconfirm -S bluez bluez-utils pipewire-pulse
    # lsmod | grep btusb   -- check whether btusb module is loaded
    #    if not:  modprobe btusb   -- to load it
    sudo systemctl enable bluetooth && systemctl start bluetooth
    # https://wiki.archlinux.org/title/Bluetooth_headset
    #bluetoothctl # - best shell tool
    # [bluetooth]# [CHG] Controller 40:A3:CC:E7:52:C9 Pairable: yes
    # [bluetooth]# power on
    # [bluetooth]# Changing power on succeeded
    # [bluetooth]# agent on
    # Agent is already registered
    # [bluetooth]# default-agent    # auto-connect paired device
    # [bluetooth]# Default agent request successful
    # [bluetooth]# scan on          # scan devices
    # next is to truct/pair/connect  mad-addr
    # [bluetooth]# scan off         # stop scan
    #
    # to make bluetooth auto load after boot
    # sudo vim /etc/bluetooth/main.conf
    #      AutoEnable=true
fi

echo ===================== done ===========================

echo run fcitx-configtool to config input method
echo run lxappearance to change theme



