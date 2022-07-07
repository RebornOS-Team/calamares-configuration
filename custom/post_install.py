#! /usr/bin/env python

import os
import os.path
import sys
import yaml
from typing import Optional, Dict, List
import subprocess
import textwrap
import pathlib

CONFIG_FILENAME: pathlib.Path = pathlib.Path("post_install.yaml")
ACCOUNTSSERVICE_CONFIG: pathlib.Path = pathlib.Path("/var/lib/AccountsService/users")

def main():
    change_to_script_directory()

    config: Optional[Dict] = None
    with open(CONFIG_FILENAME, "r") as yaml_file:    
        config = yaml.safe_load(yaml_file)
        if config is None:
            print("ERROR: Config file could not be read...", file=sys.stderr)
            exit(1)

    set_display_manager_defaults(config)

def change_to_script_directory(): 
    os.chdir(
        os.path.dirname(
            os.path.realpath(__file__)
        )
    )

def set_display_manager_defaults(config: Dict):
    content = """
        [org.freedesktop.DisplayManager.AccountsService]
        BackgroundFile="{_background_file}"

        [User]
        Language=
        Session="{_session}"
        XSession="{_xsession}"
        Icon=/home/{_user}/.face
        SystemAccount=false
    """
    content = textwrap.dedent(content)

    desktop = default_desktop(
        default_display_manager(config),
        config
    )

    for user in get_users():
        with open(ACCOUNTSSERVICE_CONFIG / user, "w") as  account_config:
            account_config.write(
                content.format(
                    _background_file= desktop["login_wallpaper"],
                    _session= desktop["session"],
                    _xsession= desktop["session"],
                    _user= user
                )
            )

def get_users() -> List[str]:
    return list(
        filter(
            lambda d: (
                pathlib.Path("/home") / d
            ).is_dir(),
            os.listdir("/home")
        )
    )

def is_installed(package_name: str) -> bool:
    if subprocess.run(
        [
            "pacman", "-Qq", package_name
        ], 
        capture_output=True
    ).returncode == 0:
        return True
    else:
        return False

def is_enabled(unit_name: str) -> bool:
    if subprocess.run(
        [
            "systemctl", "is-enabled", "--quiet", unit_name
        ], 
        capture_output=True
    ).returncode == 0:
        return True
    else:
        return False

def default_display_manager(config: Dict) -> Dict:
    installed = list(
        filter(
            lambda dm: is_installed(dm["test_package"]),
            config["display_managers"]
        )
    )

    if len(installed) == 0:
        return config["display_managers"][0]
    elif len(installed) == 1:
        return installed[0]

    enabled = list(
        filter(
            lambda dm: is_enabled(dm["test_unit"]),
            installed
        )
    )

    if len(enabled) == 0:
        return installed[0]
    else:
        return enabled[0]

def default_desktop(display_manager: Dict, config: Dict):
    installed = list(
        filter(
            lambda d: is_installed(d["test_package"]),
            config["desktops"]
        )
    )

    if len(installed) == 0:
        return config["desktops"][0]
    elif len(installed) == 1:
        return installed[0]

    for id in display_manager["default_priority"]:
        for desktop in installed:
            if id == desktop["id"]:
                return desktop

    return installed[0]

if __name__ == "__main__":
    main()
    



