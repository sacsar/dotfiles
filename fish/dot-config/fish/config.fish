if status is-interactive
    # Interactive session specific stuff
end

set -x LOCAL_BIN $HOME/.local/bin

fish_add_path $LOCAL_BIN
fish_add_path /opt/nvim-linux-x86_64/bin

# if we're switching to fish after installing pyenv, we need to make sure it's on our path
if test -d $HOME/.pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
end

# setup asdf if it's there
if test -d $HOME/.asdf
    source $HOME/.asdf/asdf.fish
end

if test -d "$HOME/.volta"
    set -gx VOLTA_HOME "$HOME/.volta"
    set -gx PATH "$VOLTA_HOME/bin" $PATH
end

# initialize various things if they're installed
command -q starship; and starship init fish | source
command -q pyenv; and pyenv init - | source
command -q mise; and mise activate fish | source
command -q direnv; and direnv hook fish | source
