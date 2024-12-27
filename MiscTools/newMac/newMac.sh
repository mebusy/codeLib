#!/bin/sh

set -e 

if [ `uname` != "Darwin" ];
then
    WORKING="/mnt/d/WORK"  # wsl2
    echo 'only support macos'
    exit 1
else
    WORKING="/Volumes/WORK/WORK"
fi


# 0
# xcode-select --install

# 1 brew
# if homebrew not installed , then install brew
if ! command -v brew &> /dev/null
then
    echo install brew...
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


# 1.1 development sdks
echo install development skds...
# if brew not installed git, then ...
brew list git &> /dev/null  || brew install git cmake \
    go rustup-init typescript node@16 mono openjdk@8 openjdk@17

# if rustup not initialized, then ...
if [ ! -d "$HOME/.cargo" ];
then
    echo install rustup...
    rustup-init
fi

# if `/Library/Java/JavaVirtualMachines/openjdk-8.jdk` not exist, then ...
if [ ! -d "/Library/Java/JavaVirtualMachines/openjdk-8.jdk" ]; then
    echo softlink openjdk@8...
    sudo ln -sfn /usr/local/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk
fi

# if `/Library/Java/JavaVirtualMachines/openjdk-17.jdk` not exist, then ...
if [ ! -d "/Library/Java/JavaVirtualMachines/openjdk-17.jdk" ]; then
    echo softlink openjdk@17...
    sudo ln -sfn /usr/local/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
fi


# brew install python-tk@3.12   necessary?
# brew install tcl-tk ?
# python -m pip install --upgrade pip



# 3. Oh-my-zsh
# if oh-my-zsh not installed , then install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ];
then
    echo install oh-my-zsh...
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


# if brew not install romkatv/powerlevel10k/powerlevel10k , then install powerlevel10k
if ! brew list romkatv/powerlevel10k/powerlevel10k &> /dev/null
then
    echo install powerlevel10k...
    brew install romkatv/powerlevel10k/powerlevel10k
fi

# 4. vim
# if brew not installed vim, then install vim
if ! brew list vim &> /dev/null
then
    echo install vim tools...
    brew install vim yarn ctags gotags flake8 eslint prettier black stylua cpplint clang-format pylint luacheck  
fi

# TODO: rustfmt conflicts with rust's cargo-fmt



# if not exist fold $WORKING/mebusy_git_codelib
if [ ! -d "$WORKING/mebusy_git_codelib" ];
then
    echo clone mebusy_git_codelib...
    git clone https://github.com/mebusy/codeLib.git $WORKING/mebusy_git_codelib
else
    echo pull mebusy_git_codelib...
    ( cd $WORKING/mebusy_git_codelib && git pull )
fi

( cd $WORKING/mebusy_git_codelib/working_settings && sh makesoftlink.sh )
( cd $WORKING/mebusy_git_codelib/working_editor_configs && sh makesoftlink_ed.sh )

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

brew install python-setuptools 
# python -m pip install setuptools # for YCMD

echo execute follow commands...
echo "( cd ~/.vim/plugged/YouCompleteMe && ./install.py --all )"  # linux: brew install gcc@11
echo "( cd ~/.vim/plugged/YouCompleteMe && rm -rf third_party/ycmd/third_party/tern_runtime/node_modules )"
echo "( cd ~/.vim/plugged/vimspector && ./install_gadget.py --all )"
echo "( cd ~/.vim/plugged/vim-prettier && yarn install --frozen-lockfile --production )"  # may remove yarn.lock

if [ `uname` != "Darwin" ];
then
    echo :Copilot setup
fi

