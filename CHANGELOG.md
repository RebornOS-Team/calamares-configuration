# CHANGELOG

## Calamares Configuration `v0.1.1` to `v0.1.7` ChangeLog

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

- A *firewall* (`firewalld`) is set up by default in the default minimal base.

- `nvidia-utils` added among options for Nvidia GPU drivers

- KDE Plasma installation now includes `plasma-wayland-session`

### For Developers

- GitHub CI for stable releases complete with GitHub-built Arch Linux packages, ChangeLog fetched from CHANGELOG.md, and MD5 CheckSums

- GitHub CI for unstable pre-releases complete with GitHub-built Arch Linux packages, ChangeLog fetched from commit history, and MD5 CheckSums

- Reorganization and renaming of project directories and updated *PKGBUILD*s to incorporate those changes in packaging

- Revamped and updated documentation

- Revamped and simplified build scripts for three packaging modes - `local`, `git`, and `stable`

- Updated *PKGBUILD*s to prevent the annoying replacement offers for the installer packages during system updates. 
