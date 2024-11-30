#!/bin/bash

set -eou pipefail

install_darwin="brew install"
install_mariner="yum install -y"
install_suse="zypper in -y"
install_manjaro="pacman -Sy"

determine_variant() {
  UNAME=$(uname)
  if [[ "$UNAME" == "Darwin" ]]; then
    echo "darwin"
  fi
  # otherwise we need to go look at /etc/os-release
  DISTRO=$(sed -n -E 's/^ID=(.+)$/\1/p' </etc/os-release)
  SHELLNOCASEMATCH=$(
    shopt -p nocasematch
    true
  )
  shopt -s nocasematch
  case "$DISTRO" in
  *mariner*) echo "mariner" ;;
  *suse*) echo "suse" ;;
  *manjaro*) echo "manjaro" ;;
  esac

  # Put nocasematch back
  $SHELLNOCASEMATCH
}

install() {
  if [[ $VARIANT != "darwin" ]]; then
    echo "Installing $1. Expect to be prompted for sudo."
    sudo $"install_$VARIANT" $1
  else
    brew install $1
  fi
}

VARIANT=$(determine_variant)

if [[ "$VARIANT" != "mariner" ]]; then
  if ! command -v stow &>/dev/null; then
    install stow
  fi
fi

if ! command -v make &>/dev/null; then
  echo "make not found on the path. Attempting to install."
  install make
fi
