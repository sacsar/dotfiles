zstyle ':znap:*' plugins-dir $XDG_DATA_HOME/zsh
source $ZNAP_HOME/znap.zsh

# znap will handle compinit for us

# User configuration sourced by interactive shells

path+=("$HOME/.local/bin")

# If we're on wsl2 and we've used the systemd hack, start it up.
if [ "$IS_WSL" = "wsl" ]; then
  source /usr/sbin/start-systemd-namespace
fi

znap prompt agnoster/agnoster-zsh-theme

# Plugins
znap source diazod/git-prune
znap source Tarrash/zsh-bd


# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

#
# History
#

# take the one from omz as it seems to be more robust
znap source zsh-users/zsh-history-substring-search

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Aliases
function sc() {
    echo "Reloading zshrc"
    source $HOME/.zshrc
}


# only alias nvim if we had to go the appimage route
if [ -f $LOCAL_BIN/nvim.appimage ]; then
    alias nvim=$LOCAL_BIN/nvim.appimage
fi

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e  # too much muscle memory for -v 

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
# zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

