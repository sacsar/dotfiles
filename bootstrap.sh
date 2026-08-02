#!/bin/bash
# shellcheck disable=SC2034

set -eou pipefail

install_darwin="brew install"
install_mariner="dnf install -y"
install_suse="zypper in -y"
install_manjaro="pacman -Sy"
install_ubuntu="apt-get install -y"

determine_variant() {
  UNAME=$(uname)
  if [[ "$UNAME" == "Darwin" ]]; then
    echo "darwin"
    return
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
  *ubuntu* | *debian*) echo "ubuntu" ;;
  esac

  # Put nocasematch back
  $SHELLNOCASEMATCH
}

install() {
  if [[ $VARIANT != "darwin" ]]; then
    echo "Installing $1. Expect to be prompted for sudo."
    local cmd="install_${VARIANT}"
    # we want word-splitting here
    # shellcheck disable=SC2086
    sudo ${!cmd} "$1"
  else
    brew install "$1"
  fi
}

mise() {
  if command -v mise &>/dev/null; then
    echo "mise is already installed ($(mise --version))."
    return
  fi
  local script
  script=$(curl -fsSL https://mise.run)
  echo "$script" | "${PAGER:-less}"
  read -r -p "Run the above script? [y/N] " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    bash <(echo "$script")
  else
    echo "Aborted." >&2
    exit 1
  fi
}

# Only execute main logic if script is run directly, not when sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  VARIANT=$(determine_variant)

  if [[ -z "$VARIANT" ]]; then
    echo "Unsupported OS: could not determine variant from /etc/os-release" >&2
    cat /etc/os-release >&2
    exit 1
  fi

  if ! command -v make &>/dev/null; then
    echo "make not found on the path. Attempting to install."
    install make
  fi

  if [[ "$1" == "--mise" ]]; then
    mise
    MISE_BIN=$(command -v mise 2>/dev/null || echo "$HOME/.local/bin/mise")
    "$MISE_BIN" install
    make setup stow
    exit 0
  fi

  if ! command -v stow &>/dev/null; then
    if [[ "$VARIANT" != "mariner" ]]; then
      install stow
    else
      make stow_install
    fi
  fi

  make "$VARIANT"
fi
