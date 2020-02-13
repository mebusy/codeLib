#!/bin/zsh

cmd="$@"
if [[ $cmd == "" ]]; 
then
    echo missing command
    exit 1
fi


input="input"
output="media"

docker run --entrypoint="" --rm -it --name manim  \
    -v `pwd`/$output:/media \
    -v `pwd`:/$input manim:v1 \
    /bin/sh -c "manim $input/$cmd" \
        | tee o.txt 

# should remore `\r` otherwise file will not found
dest=`awk -v RS='\r\n'  '/File ready at/ {print substr($4,2)}' o.txt` 
open -a vlc $dest
rm -f o.txt















