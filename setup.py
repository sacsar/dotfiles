#!/usr/bin/env python3

import subprocess
import shlex
import argparse
import sys
import logging
import shutil
import os
import pathlib

DEFAULT_STOW_DIRECTORIES = ['nvim', 'zsh']
XDG_DATA_HOME = os.environ.get("XDG_DATA_HOME", f"{pathlib.Path.home()}/.local/share")

def check_stow_installed():
    check_stow = shutil.which("stow")
    if check_stow is None:
        logging.error("Stow not found -- go download it from http://ftpmirror.gnu.org/stow.")
        exit()

def check_os():
    if not (sys.platform.startswith("linux") or sys.platform.startswith("darwin")):
        logging.error(f"Plaftform {sys.platform} is not supported, only linux and darwin")
        exit()
    return "LINUX" if sys.platform.startswith("linux") else "DARWIN"

def run_stow(dir_name, dry_run):
    command_args = ["stow", dir_name]
    if dry_run:
        command_args.append("--simulate")
    result = subprocess.run(command_args, stderr=subprocess.STDOUT)

    if result.returncode > 0:
        logging.error(f"Stowing of {dir_name} failed! See output above.")
    elif result.returncode < 0:
        logging.error(f"Stowing of {dir_name} interrupted by SIGNAL {-1 * result.returncode}")

def install_vimplug(dry_run):
    if pathlib.Path(f"{XDG_DATA_HOME}/nvim/site/autoload/plug.vim").exists():
        logging.info("vim-plug already installed.")
        return None
    if logging.info("Dry run: skipping vim-plug install"):
        return None
    logging.info("Installing vim-plug")
    args = shlex.split("sh -c 'curl -fLo \"${XDG_DATA_HOME:-$HOME/.local/share}\"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'")
    subprocess.run(args, check=True)

def main():
    parser = argparse.ArgumentParser(description="Install the dotfiles")
    parser.add_argument("--i3", action='store_true')
    parser.add_argument("--picom", action='store_true')
    parser.add_argument("--dry-run", action='store_true')
    parser.add_argument("--debug", action='store_true')

    args = parser.parse_args()

    if args.debug:
        args.dry_run = True
        logging.getLogger().setLevel(logging.DEBUG)
        logging.debug("Debug enabled. This is a dry run.")

    logging.debug(f"XDG_DATA_HOME: {XDG_DATA_HOME}")

    check_stow_installed()
    platform: str = check_os()

    if platform == "LINUX" and not (args.i3 or args.picom):
        logging.info("Note: Pass --i3 and/or picom for linux-specific setup")

    directories = DEFAULT_STOW_DIRECTORIES
    if args.i3:
        directories.append('i3')
    if args.picom:
        directories.append('picom')

    if 'nvim' in directories:
        install_vimplug(args.dry_run)

    logging.info(
        f"Commencing installation of {', '.join(directories)}...")

    for d in directories:
        run_stow(d, args.dry_run)
    

if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.INFO, format="%(levelname)s: %(message)s")
    main()