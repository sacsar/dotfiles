#!/usr/bin/env bash
#
# wezterm-build.sh — clone/update and build wezterm from source (main branch)
#
# Supports: openSUSE (Tumbleweed/Leap), Mariner/Azure Linux, macOS
#
# Usage:
#   ./wezterm-build.sh            # clone (first run) or pull + rebuild
#   WEZTERM_SRC=~/src/wezterm ./wezterm-build.sh
#   WEZTERM_BIN=~/bin ./wezterm-build.sh
#
set -euo pipefail

SRC_DIR="${WEZTERM_SRC:-$HOME/src/wezterm}"
BIN_DIR="${WEZTERM_BIN:-$HOME/bin}"
REPO_URL="https://github.com/wezterm/wezterm.git"

log() { printf '\033[1;36m==>\033[0m %s\n' "$1"; }

# shellcheck source=detect_os.sh disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/detect_os.sh"

# Map detect_os()'s raw identity to the labels this script's case branches
# below actually understand. wezterm-build only knows build-dep steps for
# macos/opensuse/mariner; everything else (manjaro, ubuntu, whatever) is
# "unknown" here and falls back to assuming deps are already installed.
wezterm_os_label() {
    case "$(detect_os)" in
    darwin) echo "macos" ;;
    opensuse) echo "opensuse" ;;
    mariner) echo "mariner" ;;
    *) echo "unknown" ;;
    esac
}

have_rust() {
    command -v cargo >/dev/null 2>&1 && command -v rustc >/dev/null 2>&1
}

install_rust() {
    if have_rust; then
        log "Rust/cargo already available ($(rustc --version)) — skipping rustup install"
        return
    fi
    log "Installing Rust via rustup (cargo/rustc not found)"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # shellcheck disable=SC1091
    source "$HOME/.cargo/env"
}

install_toolchain_and_deps() {
    local os="$1"

    install_rust

    case "$os" in
        macos)
            if ! command -v brew >/dev/null 2>&1; then
                log "Homebrew not found — skipping brew deps; get-deps will note anything missing"
            fi
            ;;
        opensuse)
            command -v git >/dev/null 2>&1 || sudo zypper --non-interactive install git
            ;;
        mariner)
            log "Installing build deps via tdnf"
            sudo tdnf install -y git openssl-devel fontconfig-devel \
                dbus-devel libxcb-devel libxkbcommon-x11-devel wayland-devel \
                mesa-libGL-devel python3 gcc pkg-config
            ;;
        *)
            log "Unrecognized OS — assuming git/system deps are already installed"
            ;;
    esac
}

clone_or_update() {
    if [[ -d "$SRC_DIR/.git" ]]; then
        log "Existing checkout found at $SRC_DIR — pulling main"
        git -C "$SRC_DIR" checkout main
        git -C "$SRC_DIR" pull --ff-only
    else
        log "Cloning wezterm into $SRC_DIR"
        git clone --depth=1 --branch=main --recursive "$REPO_URL" "$SRC_DIR"
    fi
    git -C "$SRC_DIR" submodule update --init --recursive
}

run_get_deps() {
    local os="$1"
    if [[ "$os" == "mariner" ]]; then
        log "Skipping get-deps on Mariner (unsupported by upstream script) — deps installed manually above"
        return
    fi
    if [[ -x "$SRC_DIR/get-deps" ]]; then
        log "Running get-deps"
        "$SRC_DIR/get-deps" || log "get-deps reported an issue — continuing, build may still succeed"
    fi
}

build() {
    log "Building (cargo build --release) — this can take a while"
    ( cd "$SRC_DIR" && cargo build --release )
}

install_binaries() {
    mkdir -p "$BIN_DIR"
    local bins=(wezterm wezterm-gui wezterm-mux-server strip-ansi-escapes)
    for b in "${bins[@]}"; do
        if [[ -f "$SRC_DIR/target/release/$b" ]]; then
            ln -sf "$SRC_DIR/target/release/$b" "$BIN_DIR/$b"
            log "Linked $b -> $BIN_DIR/$b"
        fi
    done
    if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
        log "NOTE: $BIN_DIR is not on your \$PATH — add: export PATH=\"$BIN_DIR:\$PATH\""
    fi
}

main() {
    local os
    os="$(wezterm_os_label)"
    log "Detected OS: $os"
    install_toolchain_and_deps "$os"
    clone_or_update
    run_get_deps "$os"
    build
    install_binaries
    log "Done. Installed version:"
    "$BIN_DIR/wezterm" --version || true
}

# Only execute main logic if script is run directly, not when sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
