#! /usr/bin/env python

import os
import os.path
import sys
import yaml
from typing import Union, Optional, Dict, List, Tuple
import shlex
import shutil
import subprocess
import textwrap
import pathlib
import logging

CONFIG_FILEPATH: pathlib.Path = pathlib.Path("post_install.yaml")
ACCOUNTSSERVICE_CONFIG_DIRPATH: pathlib.Path = pathlib.Path(
    "/var/lib/AccountsService/users")
LOG_FILEPATH: pathlib.Path = pathlib.Path("/var/log/post_install.log")

LOGGING_FORMAT: str = '%(asctime)s [%(levelname)8s] %(message)s (%(funcName)s; Line %(lineno)d)'
LOGGING_DATE_FORMAT: str = '%Y-%m-%d %H:%M:%S %Z'


def main():
    logging.basicConfig(
        format=LOGGING_FORMAT,
        datefmt=LOGGING_DATE_FORMAT,
        filename=LOG_FILEPATH,
        filemode='w',
        encoding='utf-8', level=logging.DEBUG
    )

    change_to_script_directory()

    config: Dict = load_configuration()

    copy_files()

    default_display_manager: Dict = get_default_display_manager(config=config)

    default_desktop: Dict = get_default_desktop(
        display_manager=default_display_manager,
        config=config
    )

    set_display_manager_defaults(
        desktop=default_desktop,
        config=config
    )

    configure_desktops(config=config)


def change_to_script_directory():
    logging.info(
        "Changing the working directory to the post_install.py script path...")

    script_path: str = os.path.dirname(
        os.path.realpath(__file__)
    )
    logging.debug("Script path detected: %s", script_path)

    os.chdir(script_path)


def load_configuration() -> Dict:
    logging.info(
        "Loading post_install configuration from post_install.yaml...")
    logging.debug("Configuration filepath: %s", str(CONFIG_FILEPATH))

    with open(CONFIG_FILEPATH, "r") as yaml_file:
        logging.debug("Configuration file opened...")
        config = yaml.safe_load(yaml_file)
        if config is None:
            logging.error(
                "Configuration file could not be loaded using the YAML format...")
            logging.fatal(
                "Configuration file is either empty or has invalid format... Exiting the application...")
            exit(1)
        else:
            logging.debug("Configuration file successfully parsed...")
            return config


def copy_files():
    logging.info(
        "Copying the contents of \"/var/tmp/post_install/rootfs\" to \"/\" (root)...")
    shutil.copytree(
        src="rootfs",
        dst="/",
        dirs_exist_ok=True,
    )


def get_default_display_manager(config: Dict) -> Dict:
    logging.info("Determining the default Display Manager...")

    installed, installed_ids = get_installed_display_managers(config=config)
    logging.debug(
        "\N{heavy four balloon-spoked asterisk} Installed display managers: %s", str(installed_ids))

    if len(installed) == 0:
        logging.warning("No display managers installed...")
        logging.debug("Selecting the first one from the list...")
        selected_display_manager = config["display_managers"][0]
    elif len(installed) == 1:
        logging.debug("Only one display manager detected...")
        selected_display_manager = installed[0]
    else:
        enabled = list(
            filter(
                lambda dm: is_enabled(dm["test_unit"]),
                installed
            )
        )
        enabled_ids = get_ids(enabled)
        logging.debug("Enabled display managers: %s", str(enabled_ids))

        if len(enabled) == 0:
            logging.warning("No display managers enabled...")
            logging.debug("Selecting the first one from the installed...")
            selected_display_manager = installed[0]
        else:
            logging.debug(
                "Selecting the first one found among the enabled display managers...")
            selected_display_manager = enabled[0]

    selected_display_manager_id = selected_display_manager["id"]
    logging.debug("\N{blue heart} Selected display manager: %s",
                  selected_display_manager_id)
    return selected_display_manager


def get_default_desktop(display_manager: Dict, config: Dict) -> Dict:
    logging.info("Determining the default Desktop/Window Manager...")

    installed, installed_ids = get_installed_desktops(config=config)
    logging.debug(
        "\N{heavy four balloon-spoked asterisk} Installed desktops/WMs: %s", str(installed_ids))

    selected_desktop = config["desktops"][0]
    if len(installed) == 0:
        logging.warning("No desktops or window managers installed...")
        logging.debug("Selecting the first one from the list...")
        selected_desktop = config["desktops"][0]
    elif len(installed) == 1:
        logging.debug("Only one desktop/window manager detected...")
        selected_desktop = installed[0]
    else:
        selected_desktop = installed[0]
        for id in display_manager["default_priority"]:
            for desktop in installed:
                if id == desktop["id"]:
                    selected_desktop = desktop
                    selected_desktop_id = selected_desktop["id"]
                    logging.debug(
                        "\N{blue heart} Selected desktop/WM: %s", selected_desktop_id)
                    return selected_desktop
        logging.warning(
            "No installed desktops were in the display manager priority list...")
        logging.debug("Selecting the first installed desktop found...")
    selected_desktop_id = selected_desktop["id"]
    logging.debug("\N{blue heart} Selected desktop/WM: %s",
                  selected_desktop_id)
    return selected_desktop


def set_display_manager_defaults(desktop: Dict, config: Dict):
    logging.info("Setting Display Manager defaults...")
    accountsservice_content: str = """
        [org.freedesktop.DisplayManager.AccountsService]
        BackgroundFile="{_background_file}"

        [User]
        Language=
        Session="{_session}"
        XSession="{_xsession}"
        Icon=/home/{_user}/.face
        SystemAccount=false
    """
    accountsservice_content = textwrap.dedent(accountsservice_content)

    dmrc_content: str = """
        [Desktop]
        Session="{_session}"
    """
    dmrc_content = textwrap.dedent(dmrc_content)

    for user in get_users():
        logging.debug("Setting Display Manager defaults for: %s", user)

        logging.debug("AccountsService configuration dirpath: %s",
                      str(ACCOUNTSSERVICE_CONFIG_DIRPATH))
        logging.debug(
            "Creating the parent directory for AccountsService configuration...")
        pathlib.Path(ACCOUNTSSERVICE_CONFIG_DIRPATH).mkdir(
            parents=True, exist_ok=True)
        logging.debug("Writing the AccountsService configuration...")
        with open(ACCOUNTSSERVICE_CONFIG_DIRPATH / user, "w") as account_config:
            file_content = accountsservice_content.format(
                _background_file=desktop["login_wallpaper"],
                _session=desktop["session"],
                _xsession=desktop["session"],
                _user=user
            )
            logging.debug(
                "Writing to the AccountsService configuration:\n%s", file_content)
            account_config.write(file_content)

        dmrc_dirpath = pathlib.Path("/home") / user
        logging.debug("dmrc configuration dirpath: %s", str(dmrc_dirpath))
        logging.debug(
            "Creating the parent directory for .dmrc configuration...")
        dmrc_dirpath.mkdir(parents=True, exist_ok=True)
        logging.debug("Writing the dmrc configuration...")
        with open(dmrc_dirpath / ".dmrc", "w") as dmrc_config:
            file_content = dmrc_content.format(_session=desktop["session"])
            logging.debug(
                "Writing to the dmrc configuration:\n%s", file_content)
            dmrc_config.write(file_content)


def configure_desktops(config: Dict):
    logging.info("Configuring Desktops and Window Managers...")

    installed, installed_ids = get_installed_display_managers(config=config)

    for desktop, id in zip(installed, installed_ids):
        if id == "enlightenment":
            configure_enlightenment_desktop(desktop)
        else:
            pass

def configure_enlightenment_desktop(enlightenment_config: Dict):
    logging.info("Configuring the Enlightenment Desktop...")
    disable_networkmanager = subprocess.run(
        shlex.split("systemctl disable NetworkManager.service"),
        shell= False,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
    )
    logging.debug("Running \"systemctl disable NetworkManager.service\":\n%s", disable_networkmanager.stdout)
    if disable_networkmanager.returncode != 0:
        logging.error(f"Could not disable NetworkManager. Exit code: {disable_networkmanager.returncode}")
        return

    enable_connman = subprocess.run(
    shlex.split("systemctl enable connman.service"),
        shell= False,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
    )
    logging.debug("Running \"systemctl enable connman.service\":\n%s", enable_connman.stdout)
    if enable_connman.returncode != 0:
        logging.error(f"Could not enable connman. Exit code: {enable_connman.returncode}")        

def get_ids(dicts: list[Dict]) -> list[str]:
    return list(
        map(
            lambda i: i["id"],
            dicts
        )
    )


def get_users() -> List[str]:
    logging.info("Listing all the users...")
    users_list = list(
        filter(
            lambda d: (
                pathlib.Path("/home") / d
            ).is_dir(),
            os.listdir("/home")
        )
    )
    logging.debug("Users found: %s", str(users_list))
    return users_list


def get_installed_display_managers(config: Dict) -> Tuple[list[Dict], list[str]]:
    installed = list(
        filter(
            lambda dm: are_installed(dm["test_packages"]),
            config["display_managers"]
        )
    )
    installed_ids = get_ids(installed)
    return (installed, installed_ids)


def get_installed_desktops(config: Dict) -> Tuple[list[Dict], list[str]]:
    installed = list(
        filter(
            lambda d: are_installed(d["test_packages"]),
            config["desktops"]
        )
    )
    installed_ids = get_ids(installed)
    return (installed, installed_ids)


def are_installed(package_names_given: Union[List[str], str]) -> bool:
    if isinstance(package_names_given, str):
        package_names: List[str] = [package_names_given]
    elif isinstance(package_names_given, list):
        package_names: List[str] = package_names_given

    logging.debug(f"Checking if any of {package_names} are installed...")
    for package_name in package_names:
        if subprocess.run(
            [
                "pacman", "-Qq", package_name
            ],
            capture_output=True
        ).returncode == 0:
            logging.debug(
                f"\N{heavy check mark} {package_name} is installed...")
            return True
        else:
            logging.debug(f"{package_name} is not installed...")
            continue
    logging.debug(f"None of {package_names} is installed...")
    return False


def is_enabled(unit_name: str) -> bool:
    logging.debug(f"Checking if {unit_name} is enabled...")
    if subprocess.run(
        [
            "systemctl", "is-enabled", "--quiet", unit_name
        ],
        capture_output=True
    ).returncode == 0:
        logging.debug(f"\N{heavy check mark} {unit_name} is enabled...")
        return True
    else:
        logging.debug(f"{unit_name} is not enabled...")
        return False


if __name__ == "__main__":
    main()
