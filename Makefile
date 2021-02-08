SHELL := /bin/bash

default:
	@echo "Run one of the following: mac, rhel, ubuntu"

setup:
	scripts/common.sh

mac: | mac_deps stow setup
	curl https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors -o $(HOME)/Nord.itermcolors

rhel: | setup rhel_deps rhel_nvim rhel_fzf stow linux_rg

ubuntu: | setup ubuntu_deps stow nvim_app_image

common_packages = stow pandoc jq

# Cover things that can be installed by package manager
mac_deps_INSTALL = brew install
mac_deps_PACKAGES = $(common_packages) neovim tree ripgrep coreutils fzf tmux
# omit wget for now should be there by default, I think

rhel_deps_INSTALL = sudo yum install -y
rhel_deps_PACKAGES = $(common_packages) tree

ubuntu_deps_INSTALL = sudo apt-get install -y
ubuntu_deps_PACKAGES = $(common_packages) ripgrep fzf

mac_deps rhel_deps ubuntu_deps:
	$($@_INSTALL) $($@_PACKAGES)

# putting this separately because I'm not sure it's available
rhel_fzf:
	$(rhel_deps_INSTALL) fzf

rhel_nvim:
	$(rhel_deps_INSTALL) neovim python36-neovim

# it's a little silly to include i3 and picom in os x
stow:
	stow -S -v nvim i3 picom zsh

nvim_app_image:
	scripts/neovim.sh

dircolors:
	curl https://raw.githubusercontent.com/arcticicestudio/nord-dircolors/develop/src/dir_colors -o $(HOME)/.dircolors

linux_rg: setup
	scripts/linux_ripgrep.sh
