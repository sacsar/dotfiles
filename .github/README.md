# Installation

Run `make` to see available variants:

- OS X: `make mac`
- RHEL (`yum`): `make rhel`
- OpenSUSE: `make opensuse`

(`manjaro` and `ubuntu` variants also exist, but who knows the last time I used
those.)

# Notes

To add the wezterm-nightly repo to zypper on OpenSUSE (and bump priority above
the default:
```
sudo zypper ar https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/opensuse-tumbleweed/wezfurlong-wezterm-nightly-opensuse-tumbleweed.repo
sudo zypper mr -p 10 copr:copr.fedorainfracloud.org:wezfurlong:wezterm-nightly
```
