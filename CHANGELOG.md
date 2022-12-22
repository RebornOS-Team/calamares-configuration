# CHANGELOG

## Calamares Configuration `v0.1.1` to `v0.1.4` ChangeLog

### For Users

• `ntfs-3g` removed from packages installed by default

• Package descriptions updated in the Advanced (`netinstall` module) page

• `electron` `12`-`15` removed and electron 17-20 are available

• *Budgie* theming fixed based on suggestions from Budgie devs (thanks *finnsster* for the communication)

• *Openbox* theming fixed

• *LXDE* now uses `leafpad` instead of `geany`

• *Openbox* now uses geany instead of mousepad

• *Trinity Desktop Environment (TDE)* installation fixed by using TDE's official repos and using a new custom module - `pre_install` (thanks *Panda*)

### For Developers

• Reorganization and renaming of project directories and updated *PKGBUILD*s to incorporate those changes in packaging

• Revamped and updated documentation

• Revamped and simplified build scripts for three packaging modes - `local`, `git`, and `stable`

• Updated *PKGBUILD*s to prevent the annoying replacement offers for the installer packages during system updates. 