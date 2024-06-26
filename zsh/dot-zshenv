# User configuration sourced by all invocations of the shell
: ${ZNAP_HOME=${ZDOTDIR:-${HOME}/dotfiles/zsh}/.zsh-snap}

is_wsl() {
    if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
        echo "wsl"
    elif grep -qEI "(Microsoft|WSL)" /proc/sys/kernel/osrelease &> /dev/null; then
        echo "wsl"
    else
        echo "other"
    fi
}

export EDITOR="nvim"

export IS_WSL=$(is_wsl)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.local/cache"
export LOCAL_BIN="$HOME/.local/bin"

export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
