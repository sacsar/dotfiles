#!/bin/bash
# shellcheck disable=SC2034

set -eou pipefail

install_darwin="brew install"
install_mariner="dnf install -y"
install_suse="zypper in -y"
install_manjaro="pacman -Sy"
install_ubuntu="apt-get install -y"

# shellcheck source=scripts/detect_os.sh disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/scripts/detect_os.sh"

determine_variant() {
  # detect_os() returns a raw OS identity; map it to the install_* variant
  # names this script actually knows how to act on. An OS detect_os()
  # recognizes but we don't (there is none today) or doesn't recognize at
  # all maps to nothing, which the caller treats as a fatal error.
  case "$(detect_os)" in
  darwin) echo "darwin" ;;
  opensuse) echo "suse" ;;
  mariner) echo "mariner" ;;
  manjaro) echo "manjaro" ;;
  ubuntu) echo "ubuntu" ;;
  esac
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
