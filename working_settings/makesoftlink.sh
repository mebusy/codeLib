#!/bin/sh

# to format .json
# python -m json.tool --sort-keys Homebrew.json Homebrew.json


# this script is used to create symbolic links in ~ dir to those files  

set -e

# for-loop get files in current directory

for file in *; do
    # if file is not a bash file, and not a .bak file  echo file
    if [[ $file != *.sh ]] && [[ $file != *.py ]] && [[ $file != *.bak ]] && [[ $file != Homebrew.json ]]; then
        # echo $file
        target_file=~/.$file
        if [[ $file == kitty.conf ]]; then
            mkdir -p ~/.config/kitty
            target_file=~/.config/kitty/kitty.conf
        fi

        # force solftlink to target file
        ln -sf $PWD/$file $target_file
        ls -l $target_file
    fi
done






