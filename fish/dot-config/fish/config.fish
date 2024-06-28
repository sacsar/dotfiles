if status is-interactive
    # Interactive session specific stuff
end

set -x LOCAL_BIN $HOME/.local/bin

fish_add_path $LOCAL_BIN

# if we're switching to fish after installing pyenv, we need to make sure it's on our path
if test -d $HOME/.pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
end

# initialize various things if they're installed
command -q starship; and starship init fish | source


command -q pyenv; and pyenv init - | source
