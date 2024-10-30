#bash

set -e

# array of elements  dwm, st, dmenu
tools=(dwm st dmenu)
# url path
pathes=(dwm st tools)

mkdir -p .suckless
cd .suckless

mkdir -p ~/bin

for i in ${!tools[@]}; do
    # sort and print the last line
    fname=`curl -sL https://dl.suckless.org/${pathes[$i]} | grep "${tools[$i]}-" | sort | tail -n 1 | cut -d '"' -f 2` 
    echo $fname

    # download the file
    rm -f $fname
    wget https://dl.suckless.org/${pathes[$i]}/$fname
    tar -xvf $fname
    
    # remove suffix .tar.gz from the file name
    dirname=`echo $fname | sed 's/.tar.gz//'`
    echo $dirname

    cd $dirname
    # if is Linux
    if [ "$(uname)" == "Linux" ]; then
        make clean && make
    fi

    ln -s ./$dirname/${tools[$i]} ~/bin/
done

echo "exec dwm" > ~/.xinitrc
# echo "exec dwm" > ~/.xsessionrc

