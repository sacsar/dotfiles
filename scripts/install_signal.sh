#!/usr/bin/env bash

set -eou pipefail

original_dir=$(pwd)

signal_key_fingerprint="4B16B7232DFAA439AD791002EF9F501F13EED94C"

work_dir=$(mktemp -d)
trap 'cd "$original_dir"; rm -rf "$work_dir"' EXIT

cd "$work_dir"

curl -f -L -O https://updates.signal.org/desktop/signal-desktop.AppImage
curl -f -o signal-appimage.asc https://updates.signal.org/static/desktop/appimage.asc

gpg --no-default-keyring --keyring ./signal.gpg --import signal-appimage.asc
if ! gpg --no-default-keyring --keyring ./signal.gpg --with-colons --fingerprint \
    | grep -q "^fpr:::::::::${signal_key_fingerprint}:"; then
  echo "ERROR: Signal signing key fingerprint does not match the pinned value!" >&2
  exit 1
fi

curl -f -L -O https://updates.signal.org/desktop/signal-desktop.AppImage.gpg
if ! gpg --no-default-keyring --keyring ./signal.gpg --verify signal-desktop.AppImage.gpg signal-desktop.AppImage; then
  echo "ERROR: Signal AppImage signature verification failed!" >&2
  exit 1
fi

chmod +x signal-desktop.AppImage
gearlever --integrate signal-desktop.AppImage
