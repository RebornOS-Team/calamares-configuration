# Calamares Configuration for RebornOS

[![Discord Server](https://dcbadge.vercel.app/api/server/cU5s6MPpQH?style=flat)](https://discord.gg/cU5s6MPpQH)
![GitHub](https://img.shields.io/github/license/rebornos-developers/calamares-configuration)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/rebornos-developers/calamares-configuration)
[![Release](https://github.com/RebornOS-Developers/calamares-configuration/actions/workflows/release.yml/badge.svg)](https://github.com/RebornOS-Developers/calamares-configuration/actions/workflows/release.yml)
[![Pre-Release (Git)](https://github.com/RebornOS-Developers/calamares-configuration/actions/workflows/pre_release.yml/badge.svg)](https://github.com/RebornOS-Developers/calamares-configuration/actions/workflows/pre_release.yml)

> **Note**: This project only carries RebornOS-specific configuration except for the installer packaging files (PKGBUILD, build scripts), icons, and launch scripts. For the rest of the installer's source code and for the above exceptions, please use the [calamares-core](https://github.com/RebornOS-Developers/calamares-core) project.

> **Note**: It is recommended that all module-specific configuration (`.conf`) files in the `etc/calamares/modules` directory display the URL to the *upstream configuration file* at the top (for example: `# https://github.com/calamares/calamares/blob/calamares/src/modules/welcomeq/welcomeq.conf`) so that developers can refer to the latest configuration easily.

## Cloning

In order to download the source code to your local computer for testing, or for development, you can clone from the remote repository using either SSH, or HTTPS. Below are instructions on how to do so using Gitlab hosted code as remote.

### HTTPS

```bash
git clone https://github.com/RebornOS-Developers/calamares-configuration.git 
```

OR

### SSH

```bash
git clone git@github.com:RebornOS-Developers/calamares-configuration.git
```

## Packaging

Change to the project directory (`cd calamares-configuration`) and run any of the below scripts:
- `sh packaging/setup.sh <MODE>`: Builds and installs a package
- `sh packaging/build-package.sh <MODE>`: Just builds a package without installing it locally
- `sh packaging/install-package.sh <MODE>`: Just installs a package locally, except if no built package is detected, a package is built.

- where `<MODE>` can be one of the below
     1. `local`: Selects *calamares-configuration-local* from the local project that you have cloned already.
     2. `git`: Selects *calamares-configuration-git* from the latest git commit.
     3. `stable`: Selects *calamares-configuration* from the git tag corresponding to the [`pkgver` specified in the PKGBUILD](https://github.com/RebornOS-Developers/calamares-configuration/blob/main/packaging/calamares-configuration/PKGBUILD#L4). If `pkgver=0.1.2`, then the git tag `v0.1.2` is used for packaging. 
     
> **Note**: Any additional parameters passed to the above scripts are automatically sent to `makepkg` or `pacman` (whichever is applicable).

