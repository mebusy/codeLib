#!/bin/zsh

cmd="$@"
if [[ $cmd == "" ]]; 
then
    echo missing command
    exit 1
fi

input="input"
docker run --entrypoint="" --rm -it --name manim  -v `pwd`/output:/media -v `pwd`:/$input manim:v1 /bin/sh -c "manim $input/$cmd"



