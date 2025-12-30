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
# softwareupdate --install-rosetta # TODO
# 0.1
# cd /Volumes/WORK/WORK/ && git clone https://github.com/mebusy/codeLib.git mebusy_git_codelib

if [ $instStep -le 0 ]; then
    # 1 brew
    # if homebrew not installed , then install brew
    if ! command -v brew &> /dev/null
    then
        # if ~/.profile not exist, then ...
        if [ ! -f "$HOME/.profile" ];
        then
            echo create  .profile template...
            cp ./profile_tmpl $HOME/.profile
        fi

        echo install brew...
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    fi
fi

# if os is Darwin and arm64, then ...        
if [ `uname` == "Darwin" ] && [ `uname -m` == "arm64" ];
then
    # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.profile
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ `uname` == "Linux" ];
then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi


# 1.1 development sdks
echo install development skds...

if [ $instStep -le 1 ]; then
    # if brew not installed git, then ...
    brew list git &> /dev/null  || brew install git curl cmake make \
        go rustup-init typescript node@18 mono openjdk@17 openjdk@21

    git config --global user.name "mebusy"
    git config --global user.email "golden_slime@hotmail.com"
    git config --global pull.rebase false
    
    # openjdk@8  # TODO
    # if OS is not Darwin silicon
    if [ `uname` != "Darwin" ] || [ `uname -m` != "arm64" ];
    then
        brew install openjdk@8
    fi
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
    # else  for javaVer in 8 17
    for javaVer in 8 17 21 # TODO
    do
        # if OS is Darwin silicon, and javaVer is 8, then skip
        if [ `uname` == "Darwin" ] && [ `uname -m` == "arm64" ] && [ $javaVer == 8 ];
        then
            continue
        fi

        # if `/Library/Java/JavaVirtualMachines/openjdk-${javaVer}.jdk` not exist, then ...
        if [ ! -d "/Library/Java/JavaVirtualMachines/openjdk-${javaVer}.jdk" ]; then
            echo softlink openjdk@${javaVer}...
            sudo ln -sfn `brew --prefix`/opt/openjdk@${javaVer}/libexec/openjdk.jdk \
                /Library/Java/JavaVirtualMachines/openjdk-${javaVer}.jdk
        fi
    done
fi


# 2.1. python
if [ $instStep -le 4 ]; then
    # if brew not installed python@3.11, then install
    # if ! brew list python@3.11 &> /dev/null
    # then
    #     # python 3.11,  python-setuptools is need for YCMD
    #     brew install python@3.11 python-tk@3.11 tcl-tk python-setuptools
    #     ln -s -f `brew --prefix`/bin/python3.11 `brew --prefix`/bin/python
    #     # python -m pip install --upgrade pip
    # fi
    if ! brew list pyenv &> /dev/null
    then
        brew install pyenv
        pyenv install 3.11
        pyenv global 3.11
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
    as_path=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    if [ ! -d $as_path ];
    then
        echo install zsh-autosugestions
        git clone https://github.com/zsh-users/zsh-autosuggestions  $as_path
    fi
fi


# 4. vim
if [ $instStep -le 8 ]; then
    # if brew not installed vim, then install vim
    if ! brew list vim &> /dev/null
    then
        echo install vim tools...
        brew install yarn
        brew install vim pylint flake8 eslint prettier black stylua luacheck cpplint clang-format   tlrc
    fi
fi


# rustfmt conflicts with rust's cargo-fmt

if [ $instStep -le 13 ]; then
    ( cd ../../working_settings && sh makesoftlink.sh ) 
    ( cd ../../working_editor_configs && sh makesoftlink_ed.sh ) 

    vim +PlugInstall +qall

    # source will stop the script
    source ~/.profile
    echo  !!!! run `./newMac.sh 14`   again
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

# tools normally need install in /Applications/
brew install rectangle xquartz
brew install ffmpeg mitmproxy tmux graphviz

if [ $instStep -le 20 ]; then
    if [ `uname` != "Darwin" ];
    then
        echo :Copilot setup
    fi
fi


# go install github.com/codegangsta/gin@latest
#
