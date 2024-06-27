# ironically, use bash
SHELL := /bin/bash

XDG_DATA_HOME ?= $(HOME)/.local/share
FISH := true
ZSH := false

default:
	@echo "Run one of the following: mac, rhel, ubuntu, suse"

include xdg.mk

.PHONY: setup
setup: xdg_dirs
	git submodule update --init --recursive

mac: | mac_deps stow setup
	curl https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors -o $(HOME)/Nord.itermcolors

rhel: | setup rhel_deps rhel_nvim rhel_fzf stow linux_rg

ubuntu: | setup ubuntu_deps stow nvim_app_image

manjaro: | setup manjaro_deps stow

suse: | setup suse_deps stow

common_packages = stow jq starship

# Cover things that can be installed by package manager
mac_deps_INSTALL = brew install
mac_deps_PACKAGES = $(common_packages) neovim tree ripgrep coreutils fzf tmux pandoc
# omit wget for now should be there by default, I think

rhel_deps_INSTALL = sudo yum install -y
rhel_deps_PACKAGES = $(common_packages) tree pandoc fish

ubuntu_deps_INSTALL = sudo apt-get install -y
ubuntu_deps_PACKAGES = $(common_packages) ripgrep fzf pandoc fish

manjaro_deps_INSTALL = sudo pacman -Sy
manjaro_deps_PACKAGES = $(common_packages) tree ripgrep fzf xsel neovim pandoc fish

suse_deps_INSTALL = sudo zypper in
suse_deps_PACKAGES = $(common_packages) ripgrep fzf tmux neovim pandoc-cli fish

mac_deps rhel_deps ubuntu_deps manjaro_deps suse_deps:
	$($@_INSTALL) $($@_PACKAGES)

# putting this separately because I'm not sure it's available
rhel_fzf:
	$(rhel_deps_INSTALL) fzf

rhel_nvim:
	$(rhel_deps_INSTALL) neovim python36-neovim

# it's a little silly to include i3 and picom in os x
stow:
	stow -S -v --dotfiles nvim i3 picom zsh latexmk fish

nvim_app_image:
	scripts/neovim.sh

dircolors:
	curl https://raw.githubusercontent.com/arcticicestudio/nord-dircolors/develop/src/dir_colors -o $(HOME)/.dircolors

linux_rg: setup
	scripts/linux_ripgrep.sh

$(XDG_DATA_HOME)/konsole:
	@mkdir -p $(XDG_DATA_HOME)/konsole

$(XDG_DATA_HOME)/konsole/nord.colorscheme: $(XDG_DATA_HOME)/konsole
	@curl https://raw.githubusercontent.com/nordtheme/konsole/develop/src/nord.colorscheme -o $(XDG_DATA_HOME)/konsole/nord.colorscheme

nord: | $(XDG_DATA_HOME)/konsole/nord.colorscheme dircolors
