zstyle ':znap:*' plugins-dir $XDG_DATA_HOME/zsh
zstyle ':znap:*' auto-compile no
source $ZNAP_HOME/znap.zsh

# znap will handle compinit for us

# User configuration sourced by interactive shells

path+=("$HOME/.local/bin")
fpath+=("$HOME/.local/bin/zsh")

# If we're on wsl2 and we've used the systemd hack, start it up.
if [ "$IS_WSL" = "wsl" ]; then
  source /usr/sbin/start-systemd-namespace
fi

# znap prompt agnoster/agnoster-zsh-theme

# Plugins
znap source diazod/git-prune
znap source Tarrasch/zsh-bd
znap source wfxr/forgit

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# dircolors/appearance 
if [ -f $HOME/.dircolors ]; then
    case $OSTYPE in
        *"darwin"*) eval $(gdircolors $HOME/.dircolors)
            export CLICOLORS=1;;
        *) eval $(dircolors $HOME/.dircolors);
    esac

fi

# History
#

znap source zsh-users/zsh-history-substring-search

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}
precmd_functions+=(set_win_title)
starship_precmd_user_func="set_win_title"

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

###### LOCAL CONFIG
if [ -f "$ZDOTDIR/.zshrc.local" ]; then
    source $ZDOTDIR/.zshrc.local
fi

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



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/var/lib/conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/var/lib/conda/etc/profile.d/conda.sh" ]; then
        . "/var/lib/conda/etc/profile.d/conda.sh"
    else
        export PATH="/var/lib/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if which conda > /dev/null; then
conda deactivate
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(direnv hook zsh)"

eval "$(starship init zsh)"
