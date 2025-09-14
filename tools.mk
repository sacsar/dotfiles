# Install tools I inevitably assume exist. Not really dotfiles, but skip frustration

# I don't like this pattern of variables, but it does stop us from installing
# both "manually" and via the package manager
LINUX_NVIM_DEST ?= /opt/nvim-linux64/bin/nvim
TMP_NVIM = $(shell command -v nvim)
NEOVIM = $(if $(TMP_NVIM),$(TMP_NVIM),$(LINUX_NVIM_DEST))
NEOVIM_PREREQ := $(if $(TMP_NVIM),,/tmp/nvim-linux64.tar.gz)

TMP_STARSHIP = $(shell command -v starship)
STARSHIP = $(if $(TMP_STARSHIP),$(TMP_STARSHIP),$(XDG_BIN_HOME)/starship)
STARSHIP_PREREQ :=$(if $(TMP_STARSHIP),,/tmp/starship_install.sh)
STARSHIP_INSTALL_URL := https://starship.rs/install.sh

TMP_RG = $(shell command -v rg)
RIPGREP = $(if $(TMP_RG),$(TMP_RG),$(XDG_BIN_HOME)/rg)

# define variables for the installation commands
mariner_INSTALL = sudo dnf install -y
suse_INSTALL = sudo zypper in -y
manjaro_INSTALL = sudo pacman -Sy
ubuntu_INSTALL = sudo apt-get install -y
darwin_INSTALL = brew install

# define variables for the lists of packages we want to install
# the most maintainable way to do this is have a common list
COMMON_PACKAGES = jq tree fish wget pandoc ripgrep fzf tmux xsel ncdu
suse_PACKAGES = $(filter-out pandoc,$(COMMON_PACKAGES)) pandoc-cli
ubuntu_PACKAGES = $(COMMON_PACKAGES)
manjaro_PACKAGES = $(COMMON_PACKAGES)
mariner_packages = $(filter-out ripgrep fzf neovim pandoc xsel,$(COMMON_PACKAGES)) awk tar
darwin_PACKAGES = $(filter-out wget tmux xsel tree,$(COMMON_PACKAGES)) coreutils

%_deps: $(STARSHIP)
	$($*_INSTALL) $($*_PACKAGES)

# because we need to install neovim by hand for mariner, don't pattern match it
mariner_deps: $(NEOVIM) $(STARSHIP)
	$(mariner_INSTALL) $(mariner_PACKAGES)
	$(MAKE) $(RIPGREP)

/tmp/nvim-linux-x86_64.tar.gz:
	curl -L -o $@ https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

$(NEOVIM): | $(NEOVIM_PREREQ)
	sudo rm -rf /opt/nvim*
	sudo tar -C /opt -xzf $<

$(STARSHIP): | $(STARSHIP_PREREQ)
	$< --bin-dir "${XDG_BIN_HOME}"

/tmp/starship_install.sh:
	curl -sS -o $@ $(STARSHIP_INSTALL_URL)

$(RIPGREP): /tmp/rg.tar.gz

/tmp/rg.tar.gz: RG_URL = $(shell scripts/ripgrep_linux.sh)
/tmp/rg.tar.gz:
	curl -sS -o $@ $(RG_URL)
