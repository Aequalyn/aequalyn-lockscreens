# Aequalyn Lock Screens

A collection of SDDM (Simple Desktop Display Manager) login themes curated for the
[Aequalyn](https://github.com/Aequalyn) desktop. Each theme lives in its own folder
and can be installed into `/usr/share/sddm/themes/`.

## Themes

| Theme | Author | License | Notes |
|---|---|---|---|
| Abstract Dark | Fabio Almeida ([3ximus](https://github.com/3ximus)) | CC-BY-SA | Dark abstract background |
| Echo | xCaptaiN09 | MIT | macOS Terminal style, frosted glass |
| Glyph SDDM | xCaptaiN09 | MIT | Nothing Phone aesthetic |
| Hypr SDDM | adior_enigmac | MIT | hyprlock-inspired |
| ZenMatrix Collection (PantheonSDDM) | Hyprlands / OminduD | GPLv3+ | Cinematic video backgrounds |
| Pixie SDDM | xCaptaiN09 | MIT | Pixel / Material Design 3 |
| Slice (sddm-slice) | RadRussianRus | CC-BY-SA | Simple dark theme |
| qylock themes (clockwork, material-you, nothing, winter, women-umbrella, pixel-*, R1999, osu, …) | Darkkal44 | GPLv3 | Quickshell/SDDM hybrid lock screens |

## Credits

All credit goes to the original authors of these themes. Aequalyn only curates,
patches (where needed for Qt6 compatibility) and integrates them into the
Settings app. Please support the original creators:

- **Fabio Almeida** — Abstract Dark SDDM Theme — https://github.com/3ximus/abstract-dark-sddm-theme
- **xCaptaiN09** — Echo, Glyph, Pixie SDDM — https://github.com/xCaptaiN09
- **adior_enigmac** — Hypr SDDM — https://github.com/adior_enigmac
- **Hyprlands / OminduD** — Pantheon SDDM (ZenMatrix) — https://github.com/OminduD/sddm-themes
- **RadRussianRus** — Slice SDDM — https://github.com/RadRussianRus/sddm-slice
- **Darkkal44** — qylock — https://github.com/Darkkal44/qylock

## Installation

Each theme folder contains an `install.sh` (where provided) or can be copied
manually:

```sh
sudo cp -r <theme-folder> /usr/share/sddm/themes/<theme-name>
```

Then set it in `/etc/sddm.conf` under `[Theme] Current=<theme-name>`, or use
Aequalyn's Settings → Lock Screens page.

## License

The individual themes retain their own licenses (see each folder's LICENSE file).
This repository's curation/integration code is released under the same terms as
Aequalyn.
## Documentation

- `SECURITY.md` — security model and concerns.
- `SKILL.md` — development/install skill reference.
