SHELL := /bin/bash

DIRECTORIES = $(shell ls -d -1 */ | tr -d "/")
STOW = stow -n $(1)

default:
	@echo "Run either make mac or make rhel"

mac: | mac_deps

rhel: | rhel_deps rhel_nvim rhel_fzf


# Cover things that can be installed by package manager
.SECONDEXPANSION:
mac_deps_INSTALL = brew install
mac_deps_PACKAGES = stow pandoc neovim tree wget the_silver_searcher

rhel_deps_INSTALL = sudo yum install -y
rhel_deps_PACKAGES = stow pandoc the_silver_searcher

mac_deps rhel_deps:
	$($@_INSTALL) $($@_PACKAGES)

# putting this separately because I'm not sure it's available
rhel_fzf:
	$(rhel_deps_INSTALL) fzf

rhel_nvim:
	$(rhel_deps_INSTALL) neovim python36-neovim

stow:
	@echo $(DIRECTORIES)
