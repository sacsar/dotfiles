#!/usr/bin/env bash

# make sure we initialize any submodules
git submodule update --init --recursive

# make the directories we expect
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.config/
