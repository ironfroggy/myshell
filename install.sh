#!/usr/bin/env bash

# if [ ! -a ~/.bash_default ]; then
#     mv ~/.bashrc ~/.bashrc_default
# fi
# ln -s $(pwd)/bashrc ~/.bashrc
# ln -s $(pwd)/bash_profile ~/.bash_profile
# ln -s $(pwd)/screenrc ~/.screenrc
# ln -s $(pwd)/vim ~/.vim
# ln -s $(pwd)/vimrc ~/.vimrc
# ln -s $(pwd)/xmodmap ~/.xmodmap
# ln -s $(pwd)/todo.actions.d ~/.todo.actions.d

LINK_FLAGS="-s"
if [[ "$1" == "--force" ]]; then
    LINK_FLAGS="${LINK_FLAGS}f"
fi

(
  cd dot-files
  find -mindepth 1 -type d -exec mkdir -p ~/{} \;
  find -mindepth 1 -type f -exec ln ${LINK_FLAGS} $(pwd)/{} ~/{} \;
)
