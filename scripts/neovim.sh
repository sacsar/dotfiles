#!/usr/bin/env bash

if command -v nvim &>/dev/null; then
  echo "nvim on path; skipping"
else
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux64.tar.gz
fi
