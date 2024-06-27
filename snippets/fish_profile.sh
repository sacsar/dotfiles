# https://github.com/ohmyzsh/ohmyzsh/issues/5401
# check for an interactive shell
if [[ $- == *i* ]]; then
    fishpath=$(which fish)
    export SHELL="$fishpath"
    # for zsh: use -l since we should be in a login shell
    exec "$fishpath"
else
    echo "not an interactive shell"
fi
