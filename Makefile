SHELL := /bin/bash

DIRECTORIES = $(shell ls -d -1 */ | tr -d "/")
STOW = stow $(1);

default:
	@echo "Run either make mac or make rhel"

setup:
	scripts/common.sh

mac: | mac_deps stow

rhel: | rhel_deps rhel_nvim rhel_fzf stow

# Cover things that can be installed by package manager
mac_deps_INSTALL = brew install
mac_deps_PACKAGES = stow pandoc neovim tree wget ripgrep

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
	$(foreach d,$(DIRECTORIES),$(call STOW,$(d)))
