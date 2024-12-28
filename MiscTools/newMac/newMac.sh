#!/bin/sh

set -e 

if [ `uname` != "Darwin" ];
then
    echo 'only support macos'
    exit 1
else
    WORKING="/Volumes/WORK/WORK"
fi

# the 1st param is instStep, default is 0
instStep=${1:-0}

# 0.0
# xcode-select --install
# 0.1
# cd /Volumes/WORK/WORK/ && git clone https://github.com/mebusy/codeLib.git mebusy_git_codelib

if [ $instStep -le 0 ]; then
    # 1 brew
    # if homebrew not installed , then install brew
    if ! command -v brew &> /dev/null
    then
        echo install brew...
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
fi



# 1.1 development sdks
echo install development skds...

if [ $instStep -le 1 ]; then
    # if brew not installed git, then ...
    brew list git &> /dev/null  || brew install git cmake \
        go rustup-init typescript node@18 mono openjdk@8 openjdk@17

    git config --global user.name "mebusy"
    git config --global user.email "golden_slime@hotmail.com"
    git config --global pull.rebase false
fi


if [ $instStep -le 2 ]; then
    # if rustup not initialized, then ...
    if [ ! -d "$HOME/.cargo" ];
    then
        echo install rustup... interaction needed !!!
        rustup-init
    fi
fi


# 2. java
if [ $instStep -le 3 ]; then
    # for jave 8 and 17
    for javaVer in 8 17
    do
        # if `/Library/Java/JavaVirtualMachines/openjdk-${javaVer}.jdk` not exist, then ...
        if [ ! -d "/Library/Java/JavaVirtualMachines/openjdk-${javaVer}.jdk" ]; then
            echo softlink openjdk@${javaVer}...
            sudo ln -sfn /usr/local/opt/openjdk@${javaVer}/libexec/openjdk.jdk \
                /Library/Java/JavaVirtualMachines/openjdk-${javaVer}.jdk
        fi
    done
fi

# 2.1. python
if [ $instStep -le 4 ]; then
    # if brew not installed python@3.11, then install
    if ! brew list python@3.11 &> /dev/null
    then
        # python 3.11,  python-setuptools is need for YCMD
        brew install python@3.11 python-tk@3.11 tcl-tk python-setuptools
        ln -s -f /usr/local/bin/python3.11 /usr/local/bin/python
        # python -m pip install --upgrade pip
    fi
fi

# TODO nvm

# 3. Oh-my-zsh
# if oh-my-zsh not installed , then install oh-my-zsh
if [ $instStep -le 5 ]; then
    if [ ! -d "$HOME/.oh-my-zsh" ];
    then
        echo install oh-my-zsh...
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
fi

if [ $instStep -le 6 ]; then
    # if brew not install romkatv/powerlevel10k/powerlevel10k , then install powerlevel10k
    if ! brew list powerlevel10k &> /dev/null
    then
        echo install powerlevel10k...
        brew install romkatv/powerlevel10k/powerlevel10k
    fi
fi

if [ $instStep -le 7 ]; then
    # if brew not install zsh-autosuggestions, then install zsh-autosuggestions
    if ! brew list zsh-autosuggestions &> /dev/null
    then
        echo install zsh-autosuggestions...
        brew install zsh-autosuggestions
    fi
fi


# 4. vim
if [ $instStep -le 8 ]; then
    # if brew not installed vim, then install vim
    if ! brew list vim &> /dev/null
    then
        echo install vim tools...
        brew install vim pylint flake8 eslint prettier black stylua luacheck cpplint clang-format rustup-init tlrc
    fi
fi

# rustfmt conflicts with rust's cargo-fmt

if [ $instStep -le 13 ]; then
    ( cd ../../working_settings && sh makesoftlink.sh ) 
    ( cd ../../working_editor_configs && sh makesoftlink_ed.sh ) 

    vim +PlugInstall +qall
fi

exit 99


echo $PWD

# if ~/.profile not exist, then ...
if [ ! -f "$HOME/.profile" ];
then
    echo create  .profile template...
    cp ./profile_tmpl $HOME/.profile
fi

echo now, cmd + T to open a new terminal window, and run `source ~/.profile` to apply the new settings

# 6 YCMD
# if vim plugin not installed, then ...
if [ ! -d "$HOME/.vim/plugged" ];
then
    echo please open vim to install vim-plugin
    exit 1
fi

echo install vim plugins...
vim +PlugUpdate +qall

brew install    # !important

echo execute follow commands...
echo "( cd ~/.vim/plugged/YouCompleteMe && ./install.py --all )"  # linux: brew install gcc@11
echo "( cd ~/.vim/plugged/YouCompleteMe && rm -rf third_party/ycmd/third_party/tern_runtime/node_modules )"
echo "( cd ~/.vim/plugged/vimspector && ./install_gadget.py --all )"
echo "( cd ~/.vim/plugged/vim-prettier && yarn install --frozen-lockfile --production )"  # may remove yarn.lock

if [ `uname` != "Darwin" ];
then
    echo :Copilot setup
fi

