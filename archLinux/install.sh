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

    # create initial user folders
    sudo pacman --noconfirm -S xdg-user-dirs xss-lock
    xdg-user-dirs-update
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

    sudo pacman --noconfirm -S neofetch
    neofetch
fi

# invoke ./i3wmConf/makeSoftLink.sh
./i3wmConf/makeSoftLink.sh

if [ $instStep -le 5 ]; then
    # install paru

    # rustup default stable
    echo 1 | curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # should remove pre-installed rustup ?
    # sudo pacman --noconfirm -S rustup
 
    # if paru is not installed
    if [ ! -x "$(command -v paru)" ]; then
        echo install paru...
        ( rm -rf paru && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si  )
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
    sudo pacman --noconfirm -S tmux vim yarn ctags  flake8 eslint prettier stylua cpplint luacheck python-pylint
    echo 1 | paru --skipreview gotags
    echo 1 | paru --skipreview clang-format-all-git
    paru --skipreview python-black  # can not 'echo 1 | ... ' dunno why
    echo 1 | paru --skipreview tlrc
    pyenv exec pip  install setuptools # for YCMD
fi

if [ $instStep -le 13 ]; then
    ( cd ../working_settings && sh makesoftlink.sh ) 
    ( cd ../working_editor_configs && sh makesoftlink_ed.sh ) 

    vim +PluginInstall +qall
fi

if [ $instStep -le 14 ]; then
( cd ~/.vim/plugged/YouCompleteMe && ./install.py --all && rm -rf third_party/ycmd/third_party/tern_runtime/node_modules )
fi

if [ $instStep -le 15 ]; then
    ( cd ~/.vim/plugged/vimspector && ./install_gadget.py --all )
fi
if [ $instStep -le 16 ]; then
    ( cd ~/.vim/plugged/vim-prettier && yarn install --frozen-lockfile --production )
fi

if [ $instStep -le 20 ]; then
    # if docker not installed, intall it
    if [ ! -x "$(command -v docker)" ]; then
        sudo pacman --noconfirm -S docker
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo usermod -aG docker $USER
        newgrp docker # to make the group change effective without logout
    fi
    docker --version
fi


echo ===================== done ===========================

echo run fcitx-configtool to config input method
echo run lxappearance to change theme



