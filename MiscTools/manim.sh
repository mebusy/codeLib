#!/bin/zsh
docker run --entrypoint="manim" --rm -it --name manim  -v `pwd`/output:/media -v `pwd`:/input manim:v1 $1
