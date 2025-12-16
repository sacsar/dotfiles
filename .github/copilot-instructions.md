<!-- .github/copilot-instructions.md -->

# Repo-specific instructions for AI coding agents

This repository contains the user's dotfiles. Focus on minimal, safe edits and prefer documentation-first changes. Below are the key project facts, workflows, and examples that help an AI agent be immediately productive.

- **Big picture:** this is a monorepo of dotfiles organized by tool (e.g. `nvim/`, `fish/`, `i3/`, `tmux/`, `wezterm/`, `zsh/`). Top-level build/installation orchestration is in the `Makefile` and `bootstrap.sh`. Configuration directories are under each tool's `dot-config/` subfolder (e.g. `nvim/dot-config/nvim`).

- **Primary workflows / commands**
  - Use `make` to see available install variants (e.g. `make mac`, `make suse`, `make ubuntu`).
  - Prepare the environment with `make setup` (runs `git submodule update --init --recursive` and `scripts/gitconfig.sh`).
  - Install dotfiles via GNU `stow` (Makefile target `stow` / `stow_install`). Example: `stow -S -v --dotfiles nvim i3 picom zsh latexmk fish wezterm`.
  - The repo supports being used as a submodule; prefer relative paths from `$(MAKEFILE_LIST)` when scripting.

- **Key files to read before changing behavior**
  - `Makefile` — entrypoint for install variants and `stow` invocation.
  - `bootstrap.sh` — system-detection and package-install helper code (detects Darwin, mariner, suse, manjaro).
  - `stow.mk` — how `stow` is bootstrapped/installed in environments without it.
  - `nvim/dot-config/nvim/init.lua` — Neovim entrypoint; shows `lazy.nvim` bootstrap, plugin layout, and custom commands (`:Format`, `FormatDisable`, `FormatEnable`).
  - `scripts/` — helper scripts referenced by make targets (e.g. `gitconfig.sh`, `linux_ripgrep.sh`).

- **Project-specific conventions and patterns**
  - Follow the XDG pattern — variables like `XDG_DATA_HOME` and `XDG_BIN_HOME` are used in Makefile and scripts.
  - Dotfiles are stored in tool-specific folders (e.g. `nvim/dot-config/nvim`). Add new tool configs by creating a directory at repo root and including it in the `stow` list in the `Makefile` if intended for installation.
  - Neovim plugins are managed with `lazy.nvim` under the standard `vim.fn.stdpath("data") .. "/lazy/lazy.nvim"` location; do not hard-code plugin paths in other files.
  - Avoid changing system-specific install commands in `bootstrap.sh` unless necessary; instead add platform-aware branches via `determine_variant()`.

- **Editing guidelines & examples**
  - To add a new dotfile set: create `<tool>/dot-config/<tool>/...` and update the `stow` target in the `Makefile` (and `stow` invocation list). Keep `stow_install` logic isolated in `stow.mk`.
  - To adjust Neovim behavior, prefer editing `nvim/dot-config/nvim/lua/*` modules (the repo uses `require("core.nvim.opts")`, `core.mappings`, etc.). Keep `init.lua` bootstrap minimal.
  - Example: implement a small plugin config -> add to `nvim/dot-config/nvim/lua/plugins` and ensure `require("plugins")` is reachable by `init.lua` via the `lazy.nvim` setup.

- **Integration points & external dependencies**
  - System package managers are invoked via `bootstrap.sh` helpers (`brew`, `yum`, `zypper`, `pacman`). Agents should not run those; just document commands or update scripts conservatively.
  - `stow` may be bootstrapped via `stow.mk` which uses CPAN/local::lib — be careful when editing.
  - Neovim uses `lazy.nvim`, `conform` (formatting) and LSP configs in `nvim/dot-config/nvim/lsp/`. The `:Format` command uses `conform.format()`.

- **What not to change without confirmation**
  - Do not change OS-install logic or package manager commands in `bootstrap.sh` without explicit user confirmation.
  - Do not alter the `stow` list in `Makefile` unless adding/removing a tool directory; this affects installs across OS variants.

If anything above is unclear or you want the instructions expanded with examples (e.g., a sample plugin patch), tell me which section to expand. After your feedback I'll refine the file.
