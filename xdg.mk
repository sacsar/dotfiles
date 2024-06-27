XDG_DATA_HOME ?= $(HOME)/.local/share
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_CACHE_HOME ?= $(HOME)/.cache
LOCAL_BIN ?= $(HOME)/.local/bin

XDG_DIRS := $(XDG_DATA_HOME) $(XDG_CONFIG_HOME) $(XDG_CACHE_HOME) $(LOCAL_BIN)


xdg_dirs: $(XDG_DIRS)

$(XDG_DIRS):
	mkdir -p $@
