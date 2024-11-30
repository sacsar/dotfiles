#!/bin/sh

ARCH=$(arch)

if [ "$(uname)" = "Linux" ]; then
  PLATFORM="unknown-linux"
  if [ "$ARCH" = "x86_64" ]; then
    VARIANT=musl
  else
    VARIANT=gnu
  fi
  TAR_SUFFIX="$ARCH-$PLATFORM-$VARIANT.tar.gz"
else
  echo "Install ripgrep via brew"
  exit 1
fi

download_url=$(curl -s https://api.github.com/repos/burntsushi/ripgrep/releases/latest |
  jq -r ".assets[] | select(.browser_download_url | test(\"$TAR_SUFFIX$\")) | .browser_download_url")

echo "$download_url"
# now we need to expand the tar ball and move things into place
#cd $LOCAL_BIN

#tarball_name=$(awk -F/ '{print $NF}' <<<$download_url)
#dirname=$(cut -d. -f1 $tarball_name)
#tar xvzf $tarball_name
#
#cd $dirname
#mv rg $LOCAL_BIN/rg
#
## completions into place
#mkdir -p $XDG_CONFIG_HOME/bash_completion
#mkdir -p $LOCAL_BIN/zsh
#mv 'complete/rg.bash' $XDG_CONFIG_HOME/bash_completion/
#mv 'complete/_rg' $LOCAL_BIN/zsh/
#
## now we need to clean up
#cd $LOCAL_BIN
##rm -rf dirname
