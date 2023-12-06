# CHANGELOG

## Calamares Configuration `v0.1.24`

### For Users

- Offer optional Containerization category with Docker, Podman, and Distrobox
- Offer optional Nix package manager under Frontend System > Alternative App Stores
- Start `docker.socket` instead of `docker.service`
- Include `appimagelauncher` by default
- Add the NetworkManager plugin for openconnect by default so that VPNs are accessible from the tray
- Enable printing support by default
- Replace `kgamma5` with `kgamma`
- Replace `deepin-reader` with `okular`

### For Developers

## Calamares Configuration `v0.1.23`

### For Users

- Close to 40 packages modified (added, renamed or changed in accordance with changes in Arch Linux packages).
- Do not install `cuda`, `opencl-nvidia`, `rocm-hip-sdk` or `rocm-opencl-sdk` by default

### For Developers

- CONTRIBUTING.md contains a release checklist.
- README.md contains useful links to package lists.
- Add `mkinitcpio-openswap` as a dependency.

## Calamares Configuration `v0.1.19`

### For Users

- Add `google-chrome` as an option.
- Add `gst-plugin-pipewire`.
- Make parent desktop environment groups non-checkable on the Advanced page (`netinstall` page).

### For Developers

## Calamares Configuration `v0.1.17`

### For Users

- Replace `kalendar` with `merkuro` since the former package no longer exists.

### For Developers

## Calamares Configuration `v0.1.16`

### For Users

- DNS Caching for better internet experience, using `systemd-resolved`.
- The support/information buttons on the first installer screen now function correctly. After enabling process execution from QML, only one instance of the browser tab with one URL used to open, but now multiple clicks open multiple web-pages (thanks @SoulHarsh007).
- Budgie is set to use `gnome-terminal` (instead of `gnome-console`) which better suits the Budgie themes.
- The installer theme is set to dark mode.
- The installer sidebar is moved to the bottom, in a horizontal layout.
- Installer slide background colours, installer text colors, and installer image colors all modified to suit the dark mode.
- Installer slides remade to fit the new aspect ratio.
- Better audio support with a more inclusive set of audio packages added around *pipewire*.
- Performance fix for Budgie by using `xdg-desktop-portal-gtk` instead of `xdg-desktop-portal-gnome`.
- Budgie isntallation is fixed by removing `mutter43` from the Budgie package list.
- The Grub theme is updated (thanks @SoulHarsh007).
- The installer screenshot resolution is fixed for the Trinity desktop (thanks @SoulHarsh007).
- Installations with swap and encryption fixed by adding `mkinitcpio-openswap`.
- Cutefish is removed since it is no longer in development.
  
### For Developers

- The number of installation retries is reduced to two (from five earlier).
- Removed or replaced partial upgrades.
- Renamed the RebornOS GitHub organization from `RebornOS-Developers` to `RebornOS-Team`.
- Updated `.gitignore` to ignore *Visual Studio Code* files.
- Removed self conflicts in the `PKGBUILD`s.
- The `README.md` documentation is updated.

## Calamares Configuration `v0.1.10` to `v0.1.14` ChangeLog

### For Users

- Fix encrypted installation with swap by adding the `mkinitcpio-openswap` package which supplies the `openswap` mkinitcpio hook.
- Fix Budgie installation by replacing `xdg-desktop-portal-gnome` with `xdg-desktop-portal-gtk`.
- Remove the *Cutefish* desktop environment.
- Replace `ttf-nerd-fonts-symbols-2048-em` with `ttf-nerd-fonts-symbols` for the *Sway* Window Manager (thanks @CookieSource).
- Replace `obkey` with `lxhotkey-gtk3` for the *Openbox* Window Manager (thanks @CookieSource).
- Rename Budgie's `mutter` to `mutter43` (thanks @CookieSource).
- Rename `deepin-wayland` to `deepin-wayland-protocols` (thanks @CookieSource).
- Remove `nvidia-340xx-dkms`, `fdisk`, `exfat-utils`, `reiserfsprogs`, and `reiser4progs` (thanks @SoulHarsh007).
- Replace `xfce4-screenshooter` with `gnome-screenshot` on the *Cinnamon* desktop environment (thanks @CookieSource).
- Fix system user accounts being displayed at Trinity login screen (thanks @Rippanda12).
- Add the *Sway* Window Manager.
- Add `pavucontrol` to Xfce (thanks @CookieSource).
- Add `nano` and `micro` under Console packages (thanks @cake03).

## Calamares Configuration `v0.1.1` to `v0.1.10` ChangeLog

### For Users

- `ntfs-3g` removed from packages installed by default

- Package descriptions updated in the Advanced (`netinstall` module) page

- `electron` `12`-`15` removed and electron 17-20 are available

- *Budgie* theming fixed based on suggestions from Budgie devs (thanks *finnsster* for the communication)

- *Openbox* theming fixed

- *Trinity Desktop Environment (TDE)* installation fixed by using TDE's official repos and using a new custom module - `pre_install` (thanks *Panda*)

- *LXDE* now uses `leafpad` instead of `geany`

- *Openbox* now uses geany instead of mousepad

- `gnome-todo` is replaced by `endeavour`

- `vino` is replaced by `gnome-remote-desktop`

- The exhaustive *Gnome* group is now marked as *non-critical*. Renamed or missing packages here will not fail the installation.

- `gvfs` and related backends installed in the default minimal base so that file managers can see all USB devices and remote devices.

- *Bluetooth* set up by default in the default minimal base.

- A *firewall* (`gufw`) is set up by default in the default minimal base.

- `nvidia-utils` added among options for Nvidia GPU drivers

- KDE Plasma installation now includes `plasma-wayland-session`
  
- *Xfce* includes `engrampa` for archive management
  
- *MATE* includes `mate-hud` for quick navigation

- Fonts included by default to avoid missing characters

- *Cinnamon* includes `mintlocale` and `cinnamon-translations` for localization

- `flatseal` added for permission management under the *Flatpak* category

- `appimagelauncher` added under the *Appimages* category to simplify handling of appimages

- LTE Kernel support for offline installations too

- Discord added as an option in the advanced page

- *Cinnamon* will use `gnome-terminal` instead of `mate-terminal`

- `electron18` removed

- `i3-gaps` replaced by `i3-wm`

- `python-dbus` replaced by `dbus-python`

### For Developers

- GitHub CI for stable releases complete with GitHub-built Arch Linux packages, ChangeLog fetched from CHANGELOG.md, and MD5 CheckSums

- GitHub CI for unstable pre-releases complete with GitHub-built Arch Linux packages, ChangeLog fetched from commit history, and MD5 CheckSums

- Reorganization and renaming of project directories and updated *PKGBUILD*s to incorporate those changes in packaging

- Revamped and updated documentation

- Revamped and simplified build scripts for three packaging modes - `local`, `git`, and `stable`

- Updated *PKGBUILD*s to prevent the annoying replacement offers for the installer packages during system updates. 

- Xfce configuration for offline installations through pre-install file copies and shellprocess commands
