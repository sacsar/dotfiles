XDG_DATA_HOME ?= $(HOME)/.local/share
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_CACHE_HOME ?= $(HOME)/.cache
LOCAL_BIN ?= $(HOME)/.local/bin
XDG_BIN_HOME = $(LOCAL_BIN)

XDG_DIRS := $(XDG_DATA_HOME) $(XDG_CONFIG_HOME) $(XDG_CACHE_HOME) $(XDG_BIN_HOME)

.PHONY: xdg_dirs
xdg_dirs: $(XDG_DIRS)

$(XDG_DIRS):
	mkdir -p $@
