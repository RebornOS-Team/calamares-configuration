#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
#   SPDX-FileCopyrightText: 2022 Panda <panda@rebornos.org>

import os
import shutil
from typing import Optional, Union, Dict, List

import libcalamares
from libcalamares.utils import gettext_path, gettext_languages


import gettext
_ = gettext.translation("calamares-python",
                        localedir=libcalamares.utils.gettext_path(),
                        languages=libcalamares.utils.gettext_languages(),
                        fallback=True).gettext


def pretty_name():
    return _("Running pre-install commands")

def pick_out_packages(item: Union[Dict, List, str], cumulative_package_list: List[str]):
    if isinstance(item, dict):
        for key in item: 
            if key == "packages":
                for package in item["packages"]:
                    if isinstance(package, dict):
                        if "name" in package:                            
                            if package["name"] is not None:
                                cumulative_package_list.append(package["name"])
                    elif isinstance(package, str):
                        cumulative_package_list.append(package)
            else:
                pick_out_packages(item= item[key], cumulative_package_list= cumulative_package_list)
    elif isinstance(item, list):
        for list_item in item:
            pick_out_packages(item= list_item, cumulative_package_list= cumulative_package_list)

cumulative_package_list: list[str] = []

def run():
    packagechooser = libcalamares.globalstorage.value("netinstallAdd")
    package = libcalamares.job.configuration["package"]
    pre_commands = libcalamares.job.configuration["pre-install"]
    netinstall = libcalamares.globalstorage.value("packageOperations")
    print(netinstall)
    pick_out_packages(item= packagechooser, cumulative_package_list= cumulative_package_list)
    print(pre_commands)
    if package in cumulative_package_list:
        libcalamares.utils.debug("Running pre-install commands for: {}".format(package))
        for command in pre_commands:
            command_ = [
                "/usr/bin/sh",
                "-c",
                command,
            ]
            libcalamares.utils.debug("Running command: {}".format(command))
            libcalamares.utils.target_env_call(command_)
    else:
        libcalamares.utils.debug("Match not found")
    return None
