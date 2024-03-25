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

# TODO
rustup-init

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

# 2 python
# if pyenv not installed , then install pyenv
if ! command -v pyenv &> /dev/null
then
    echo install pyenv...
    brew install pyenv
fi


# 2.1 python 3.11
# if pyenv has not installed python 3.11, then install python 3.11
if ! pyenv versions | grep 3.11 &> /dev/null
then
    echo install python 3.11...

    if [ `uname` != "Darwin" ];
    then
        brew uninstall pyenv
        brew install python@3.12
    else
        pyenv install 3.11.6
        pyenv global 3.11.6
        brew install python-tk@3.11        
    fi
fi

echo upgrade pip
alias python='$(pyenv root)/versions/3.11.6/bin/python'
python -m pip install --upgrade pip

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
    brew install vim yarn ctags gotags flake8 eslint prettier black stylua cpplint clang-format 
fi

# TODO: rustfmt conflicts with rust's cargo-fmt

# 5 vim pre-requisites
# if vundle not installed , then install vundle
if [ ! -d "$HOME/.vim/bundle/vundle" ];
then
   echo install vundle...
   git clone https://github.com/mebusy/vundle.git ~/.vim/bundle/vundle
fi

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
# if `which vim` is not equal `/usr/local/bin/vim`, then exits
if [ `which vim` != "/usr/local/bin/vim" ];
then
    echo "vim is not installed by brew, please install vim by brew"
    exit 1
fi

echo install vim plugins...
vim +BundleInstall +qall
# vim +BundleUpdate +qall

echo execute follow commands...
echo "( cd ~/.vim/bundle/YouCompleteMe && ./install.py --all )"  # linux: brew install gcc@11
echo "( cd ~/.vim/bundle/YouCompleteMe && rm -rf third_party/ycmd/third_party/tern_runtime/node_modules )"
echo "( cd ~/.vim/bundle/vimspector && ./install_gadget.py --all )"
echo "( cd ~/.vim/bundle/vim-prettier && yarn install --frozen-lockfile --production )"  # may remove yarn.lock

if [ `uname` != "Darwin" ];
then
    echo :Copilot setup
fi

