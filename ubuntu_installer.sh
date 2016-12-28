#!/bin/sh

pwd=`pwd`

clear_ycmd_and_exit(){
    rm -rf ycmd
    cd $pwd
    exit 1
}

echo "Input root password:"
stty -echo
read password
stty echo
echo $password | sudo -S apt-get update || exit 1
if [ -z `which pip` ]; then
    wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py || exit 1;
    echo $password | sudo -S python get-pip.py || exit 1;
    rm get-pip.py
fi
echo $password | sudo -S pip install flake8 jedi ipython || exit 1

# ycmd
echo $password | sudo -S apt-get install build-essential cmake python-dev || exit 1
if [ ! -d ycmd ]; then
    git clone https://github.com/Valloric/ycmd.git || exit 1;
    cd ycmd;
    git submodule update --init --recursive || clear_ycmd_and_exit;
    # Use local clang installer
    CLANG_PREBUILT="clang+llvm-3.9.0-x86_64-opensuse13.2.tar.xz"
    if [ -f $CLANG_PREBUILT ]; then
        cp -a $CLANG_PREBUILT clang_archives/;
    fi;
    ./build.py  --clang-completer ||  clear_ycmd_and_exit;
    cd $pwd
fi

echo "Done."

