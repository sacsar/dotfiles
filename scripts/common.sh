#!/usr/bin/env bash

set +x
# make sure we initialize any submodules
git submodule update --init --recursive

# make the directories we expect
source ../zsh/.zshenv
mkdir -p $XDG_DATA_HOME/zsh
mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_CACHE_HOME
mkdir -p $LOCAL_BIN
