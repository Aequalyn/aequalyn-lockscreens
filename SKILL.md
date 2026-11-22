---
name: aequalyn-lockscreens
description: Curated SDDM lock screen themes for Aequalyn.
---

# Aequalyn Lock Screens — skill

## Overview

A collection of SDDM (Simple Desktop Display Manager) login themes curated for the
Aequalyn desktop. Each theme lives in its own folder and can be installed into
`/usr/share/sddm/themes/`. 50 theme directories total: 8 standalone + 42 `qylock-*`
Quickshell/SDDM hybrids.

## Themes

### Standalone
- **Aequalyn** — default branded, minimal; MIT; uses `Aequalyn-Regular.ttf`, SVG logo;
  `theme.conf` colors/font/clock.
- **Abstract Dark** — dark abstract bg; CC-BY-SA; `background.png`, `theme.conf`.
- **Echo** — macOS Terminal aesthetic; MIT; pure/frosted modes, boot log, sysinfo from
  `/proc`; install.sh.
- **Glyph** — Nothing Phone aesthetic; MIT; `assets/images/background.jpg`, avatar;
  install.sh.
- **Hypr SDDM** — hyprlock-inspired; MIT; Material You colors, virtual keyboard;
  install.sh with Qt5/Qt6 detection.
- **Pixie** — Pixel/Material Design 3; MIT; install.sh, flake.nix.
- **Slice** — simple dark theme; CC-BY-SA; translations (nl/ru).
- **ZenMatrix Collection** — Pantheon SDDM; GPLv3+; cinematic looping video backgrounds
  (37 variants in `zenmatrix/Themes/` + matching videos in `zenmatrix/Backgrounds/`).

### qylock (42 variants)
Quickshell/SDDM hybrid lock screens by Darkkal44. Variants: clockwork (orbital/
neo-orbital/tape), dog-samurai, enfield, field, forest, Genshin, girl-coffee,
girl-pillow, last-of-us, man-bicycle, material-you (light/dark), minecraft, nier-automata,
ninesols, ninja_gaiden, nothing, osu, osumania, pixel-* (14), R1999_1/2, skyrim,
star-rail, sword, terraria, windows_7, winter, women-umbrella, wuwa. Some folders have
inconsistent curation (e.g. `qylock-R1999_2` lacks `theme.conf`).

## Install

Manual:
```sh
sudo cp -r <theme-folder> /usr/share/sddm/themes/<theme-name>
```
Then set `Current=<theme-name>` in `/etc/sddm.conf` or `/etc/sddm.conf.d/`, or use
Aequalyn Settings → Lock Screens.

- **ZenMatrix:** `zenmatrix/install.sh` (TUI, 7 steps: deps, fonts, copy, SDDM config,
  variant selection, avatar, service enable; supports Arch/Fedora/Ubuntu/openSUSE/Void;
  optional `gum` TUI; downloads extra fonts via curl; preview via
  `sddm-greeter-qt6 --test-mode`).
- **Echo/Glyph/Pixie:** their `install.sh` scripts (root required, NixOS check,
  backup/restore user config, optional apply).
- **Hypr:** `hypr/install.sh` + `hypr/test.sh`; Qt5/Qt6 detection; optional auto-apply;
  virtual keyboard config.
- **qylock themes:** no install.sh; manual copy (Quickshell hybrid).

## Security

See `SECURITY.md`. SDDM greeter executes theme QML; malicious themes can run code in
greeter context (SDDM runs as root). Review themes before installing; only trusted
sources. Install scripts perform privileged operations (`sudo`, `rm -rf`, writes
`/etc/sddm.conf*`, enables services). ZenMatrix downloads fonts from remote GitHub URLs
via `curl`. Hypr/Pixie installers auto `git checkout` branches when run from a git
checkout (supply-chain/branch-switch risk). Echo reads `/etc/os-release`, `/proc/*` via
XHR for sysinfo (information exposure in greeter). Prefer themes with clear licenses and
known authors (README credits).

## Key paths

- `SKILL.md`, `SECURITY.md`, `README.md`
- `zenmatrix/install.sh`, `zenmatrix/Main.qml`, `zenmatrix/metadata.desktop`
- `zenmatrix/Themes/`, `zenmatrix/Backgrounds/`
- `echo/install.sh`, `glyph/install.sh`, `hypr/install.sh`, `pixie/install.sh`

## References

- Aequalyn lockscreens: https://github.com/Aequalyn/aequalyn-lockscreens
- Aequalyn core: https://github.com/Aequalyn/aequalyn
- Aequalyn shell: https://github.com/Aequalyn/aequalyn-shell
- Aequalyn store: https://github.com/Aequalyn/aequalyn-store
