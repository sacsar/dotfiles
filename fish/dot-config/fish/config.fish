if status is-interactive
    # Interactive session specific stuff
end

set -x LOCAL_BIN $HOME/.local/bin

fish_add_path $LOCAL_BIN

# initialize various things if they're installed
command -q starship; and starship init fish | source
command -q pyenv; and pyenv init - | source
