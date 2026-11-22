# Aequalyn Lock Screens — security notes

- Each theme is a set of files installed into `/usr/share/sddm/themes/`; review before
  installing.
- Themes may include scripts or executables; only install from trusted sources.
- Qt5/Qt6 compatibility patches are applied by Aequalyn; verify the patch does not
  alter behavior unexpectedly.
- SDDM runs as root; a malicious theme can execute code in that context.
- Prefer themes with clear licenses and known authors (see README credits).
