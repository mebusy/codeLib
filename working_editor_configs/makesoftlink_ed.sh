#!bash

# this script is used to create symbolic links in /Volumes/WORK dir to those files  

set -e

TARGET_DIR=/Volumes/WORK
if [ "$(uname)" = "Linux" ]; then
    TARGET_DIR=~/WORK
fi

# for-loop get files in current directory

for file in *; do
    # if file is not a bash file, and not a directory
    if [[ ! $file == *.sh ]] && [[ ! -d $file ]]; then
        target_file=${TARGET_DIR}/.$file
        # force solftlink to target file
        ln -sf $PWD/$file $target_file
        ls -l $target_file
    fi
done






