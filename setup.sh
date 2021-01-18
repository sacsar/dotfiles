#!/usr/bin/env bash

if ! command stow &> /dev/null
then
    echo "Stow not found -- go download it from http://ftpmirror.gnu.org/stow/"
    exit
fi

# install vimplug for nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
