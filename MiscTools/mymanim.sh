#!/bin/zsh

cmd="$@"
if [[ $cmd == "" ]]; 
then
    echo missing command

    docker run --entrypoint="" --rm -it --name manim  \
        manim:v1 manim

    exit 1
fi


# inner input dir
d_input="/tmp/input"

d_output="/tmp/output"

# external output dir
output="/Volumes/RamDisk/manim_output"

docker run --entrypoint="" --rm -it --name manim  \
    -w $d_input \
    -v `pwd`:$d_input \
    -v $output:$d_output \
    -e PYTHONPATH=$d_input \
    manim:v1 \
    /bin/sh -c "manim --media_dir=$d_output $cmd" \
        | tee o.txt 

# should remore `\r` otherwise file will not found
dest=`awk -v RS='\r\n'  '/File ready at/ {print substr($4,2)}' o.txt` 

if [[ $dest == "" ]]; 
then
    echo failed
    exit 1
fi

# open -a vlc $dest
open $output/${dest:${#d_output}}
rm -f o.txt


