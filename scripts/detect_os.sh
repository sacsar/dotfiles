#!/usr/bin/env bash
# Shared OS/distro identity detection, sourced by bootstrap.sh and
# scripts/wezterm-build.sh.
#
# detect_os() only answers "what OS family is this" -- darwin, opensuse,
# mariner, manjaro, ubuntu, or unknown. It does NOT decide what a caller
# should do about it: bootstrap.sh needs a package-manager install command
# for a closed set of 5 variants (and treats "unknown" as fatal), while
# wezterm-build.sh only knows build-dep steps for 3 of them (and treats
# anything else as a soft "assume deps are already installed" fallback).
# Each caller keeps its own mapping from this raw identity to what it
# actually needs.
detect_os() {
  if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "darwin"
    return
  fi

  if [[ ! -r /etc/os-release ]]; then
    echo "unknown"
    return
  fi

  local id id_like
  id=$(sed -n -E 's/^ID=(.+)$/\1/p' </etc/os-release)
  id_like=$(sed -n -E 's/^ID_LIKE=(.+)$/\1/p' </etc/os-release)

  local restore_nocasematch
  restore_nocasematch=$(shopt -p nocasematch)
  shopt -s nocasematch

  case "$id:$id_like" in
  *mariner* | *azurelinux*) echo "mariner" ;;
  *suse*) echo "opensuse" ;;
  *manjaro*) echo "manjaro" ;;
  *ubuntu* | *debian*) echo "ubuntu" ;;
  *) echo "unknown" ;;
  esac

  # shellcheck disable=SC2086
  $restore_nocasematch
}
