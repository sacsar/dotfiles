SHELL := /bin/bash

default:
	@echo "Run one of the following: mac, rhel, ubuntu"

setup:
	scripts/common.sh

mac: | mac_deps stow setup

rhel: | rhel_deps rhel_nvim rhel_fzf stow

ubuntu: | ubuntu_deps stow nvim_app_image

# Cover things that can be installed by package manager
mac_deps_INSTALL = brew install
mac_deps_PACKAGES = stow pandoc neovim tree ripgrep
# omit wget for now should be there by default, I think

rhel_deps_INSTALL = sudo yum install -y
rhel_deps_PACKAGES = stow pandoc the_silver_searcher tree

ubuntu_deps_INSTALL = sudo apt-get install -y
ubuntu_deps_PACKAGES = stow pandoc ripgrep fzf

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
