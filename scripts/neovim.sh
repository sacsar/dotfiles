#!/usr/bin/env bash

start_dir=$(pwd)

nvim_exists() {
    # this can fail because we don't have ZSH's aliases because bash
    type nvim > /dev/null;
    $? || [ -f "$LOCAL_BIN/nvim.appimage" ]
}

if [[ nvim_exists ]]; then
    echo "nvim already available; skipping"
    cd $start_dir
    exit 0
fi

cd $LOCAL_BIN

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

cd $start_dir
