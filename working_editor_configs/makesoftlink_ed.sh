#!bash

# this script is used to create symbolic links in /Volumes/WORK dir to those files  

set -e

TARGET_DIR=/Volumes/WORK

# if args 1 is a path, overwrite TARGET_DIR
if [ -n "$1" ]; then
    # if $1 is a directory
    if [ -d $1 ]; then
        TARGET_DIR=$1
    fi
fi


if [ "$(uname)" = "Linux" ]; then
    TARGET_DIR=~/WORK
fi

# if exsit $1
if [ -n "$1" ]; then
    TARGET_DIR=$1
fi

RamDisk_DIR="/Volumes/RamDisk"


# for dir in both TARGET_DIR and RamDisk_DIR
for  DIR in $TARGET_DIR $RamDisk_DIR; do
    # if dir not exists, create it
    if [ -d $DIR ]; then

        # for-loop get files in current directory
        for file in *; do
            # if file name is "ctags"
            if [[ $file == ctags ]]; then
                target_file=~/.ctags
                # force solftlink to target file
                ln -sf $PWD/$file $target_file
                ls -l $target_file
            elif [[ $file == "ycm_extra_conf.py" ]]; then
                echo skip $file
            elif [[ ! $file == *.sh ]] && [[ ! -d $file ]]; then
                # if file is not a bash file, and not a directory
                target_file=${DIR}/.$file
                # force solftlink to target file
                ln -sf $PWD/$file $target_file
                ls -l $target_file
            fi
        done


        for file in eslint_prettier/JS/*; do
            if [[ ! $file == *.sh ]] && [[ ! $file == *.eslintrc.js ]]  && [[ ! -d $file ]]; then
                # remove path from $file
                fileName=${file##*/}
                target_file=${DIR}/$fileName
                # force solftlink to target file

                # ln -sf $PWD/$file $target_file
                # ls -l $target_file
                #
                # # if the file is not starts with dot ".", then hidden it's target file
                # if [[ ! $fileName == .* ]]; then
                #     # if is Darwin
                #     if [ "$(uname)" = "Darwin" ]; then
                #         # use -h to hidden a symbol link
                #         chflags -h hidden $target_file
                #     fi
                # fi
                rm -f $target_file
            fi
        done


    fi
done


