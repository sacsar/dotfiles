#!/usr/bin/env bash

# make sure we initialize any submodules
git submodule update --init --recursive

# make the directories we expect
source zsh/.zshenv  # make will run this from dotfiles/
mkdir -p $XDG_DATA_HOME/zsh
mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_CACHE_HOME
mkdir -p $LOCAL_BIN
