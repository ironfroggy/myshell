#!/usr/bin/env bash
if [ ! -a ~/.bash_default ]; then
    mv ~/.bashrc ~/.bashrc_default
fi
ln -s $(pwd)/bashrc ~/.bashrc
ln -s $(pwd)/bash_profile ~/.bash_profile
ln -s $(pwd)/screenrc ~/.screenrc
ln -s $(pwd)/vim ~/.vim
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/xmodmap ~/.xmodmap
