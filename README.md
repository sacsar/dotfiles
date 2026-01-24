# Installation

## Quick Start

Run `make` to see available installation variants for your OS:

- macOS: `make mac`
- MarinerOS: `make mariner`
- OpenSUSE: `make suse`
- Manjaro: `make manjaro`
- Ubuntu: `make ubuntu`

## Architecture

This repo uses three tools for different purposes:

1. **`bootstrap.sh`** — Complete installation script
   - Detects your OS variant (`darwin`, `mariner`, `suse`, `manjaro`, `ubuntu`)
   - Ensures `make` and `stow` are installed (prerequisites)
   - Runs the full installation automatically—**this is the only command you need**

2. **`Makefile`** — Installation orchestration (optional)
   - Defines OS-specific targets (`make mac`, `make suse`, etc.)
   - Manages GNU `stow` invocation to symlink dotfiles
   - Runs setup tasks (git submodules, git config)
   - May download additional resources (nord themes, colorschemes)
   - Useful if you only want to run setup tasks without bootstrap

3. **`Taskfile.yml`** — Development/testing only
   - Builds and tests the Lua modules in `src/lua/` (the dotfiles library)
   - Not needed for installing dotfiles; separate from the main workflow

## Workflow

```bash
# Complete setup
./bootstrap.sh
```

Or if you prefer to use make directly:
```bash
make <variant>  # e.g., make suse
```

## Notes

To add the wezterm-nightly repo to zypper on OpenSUSE (and bump priority above the default):
```bash
sudo zypper ar https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/opensuse-tumbleweed/wezfurlong-wezterm-nightly-opensuse-tumbleweed.repo
sudo zypper mr -p 10 copr:copr.fedorainfracloud.org:wezfurlong:wezterm-nightly
```
