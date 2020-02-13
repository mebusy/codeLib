#!/bin/zsh

cmd="$1"
if [[ $cmd == "" ]]; 
then
    echo missing command
    exit 1
fi

docker run --entrypoint="manim" --rm -it --name manim  -v `pwd`/output:/media -v `pwd`:/input manim:v1 $cmd


