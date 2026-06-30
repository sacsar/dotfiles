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

VERSION=$(curl -sI https://github.com/BurntSushi/ripgrep/releases/latest \
  | grep -i '^location:' | tr -d '\r' | awk -F'/' '{print $NF}')

echo "https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep-${VERSION}-${TAR_SUFFIX}"
