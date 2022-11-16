#!bash

# this script is used to create symbolic links in ~ dir to those files  

set -e

# for-loop get files in current directory

for file in *; do
    # if file is not a bash file, echo file
    if [[ ! $file == *.sh ]]; then
        # echo $file
        target_file=~/.$file
        # force solftlink to target file
        ln -sf $PWD/$file $target_file
        ls -l $target_file
    fi
done






