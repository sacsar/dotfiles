# ironically, use bash
SHELL := /bin/bash

XDG_DATA_HOME ?= $(HOME)/.local/share
XDG_BIN_HOME ?= $(HOME)/.local/bin
FISH := true
ZSH := false

default:
	@echo "Run one of the following: mac, mariner, ubuntu, suse"

include xdg.mk
include tools.mk
include stow.mk

.PHONY: setup
setup: xdg_dirs
	@git submodule update --init --recursive
	@scripts/gitconfig.sh

mac: | mac_deps stow setup
	curl https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors -o $(HOME)/Nord.itermcolors

mariner: | setup mariner_deps stow

ubuntu: | setup ubuntu_deps stow

manjaro: | setup manjaro_deps stow

suse: | setup suse_deps stow

# putting this separately because I'm not sure it's available
mariner_fzf:
	$(mariner_INSTALL) fzf

# it's a little silly to include i3 and picom in os x
stow: setup stow_install
	stow -S -v --dotfiles nvim i3 picom zsh latexmk fish

dircolors:
	curl https://raw.githubusercontent.com/arcticicestudio/nord-dircolors/develop/src/dir_colors -o $(HOME)/.dircolors

linux_rg: setup
	scripts/linux_ripgrep.sh

$(XDG_DATA_HOME)/konsole:
	@mkdir -p $(XDG_DATA_HOME)/konsole

$(XDG_DATA_HOME)/konsole/nord.colorscheme: $(XDG_DATA_HOME)/konsole
	@curl https://raw.githubusercontent.com/nordtheme/konsole/develop/src/nord.colorscheme -o $(XDG_DATA_HOME)/konsole/nord.colorscheme

nord: | $(XDG_DATA_HOME)/konsole/nord.colorscheme dircolors
