/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2021 Anke Boersma <demm@kaosx.us>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 *   Calamares is Free Software: see the License-Identifier above.
 *
 */

import io.calamares.core 1.0
import io.calamares.ui 1.0

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Column {
    id: column
    anchors.centerIn: parent
    spacing: 7

    ButtonGroup {
        id: switchGroup
    }

    Rectangle {
        //id: rectangle
        width: 700
        height: 40
        color: "#2a2e32"
        border.width: 0
        Text {
            height: 25
            anchors.centerIn: parent
            text: qsTr("Please select a <strong>bootloader</strong> option for your install, or leave the already selected default option, <strong>GRUB</strong>.")
            font.pointSize: 12
            color: "#ffffff"
            wrapMode: Text.WordWrap
        }
    }

    Rectangle {
        width: 700
        height: 90
        color: "#1b1e20"
        radius: 5
        border.width: 1
        border.color: "#646b75"
        Text {
            width: 600
            height: 40
            x: 25
            y: 10
            text: qsTr("<strong>GRUB</strong>: a feature-rich and customizable bootloader that has broad compatibility with various filesystems.")
            font.pointSize: 12
            color: "#ffffff"
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -20.0
            wrapMode: Text.WordWrap
        }

        Switch {
            id: grub_switch
            x: 500
            y: 65
            width: 187
            height: 14
            text: qsTr("GRUB")
            checked: true
            hoverEnabled: true
            ButtonGroup.group: switchGroup


            indicator: Rectangle {
                implicitWidth: 40
                implicitHeight: 14
                radius: 10
                color: grub_switch.checked ? "#3498db" : "#B9B9B9"
                border.color: grub_switch.checked ? "#3498db" : "#cccccc"

                Rectangle {
                    x: grub_switch.checked ? parent.width - width : 0
                    y: (parent.height - height) / 2
                    width: 20
                    height: 20
                    radius: 10
                    color: grub_switch.down ? "#cccccc" : "#ffffff"
                    border.color: grub_switch.checked ? (grub_switch.down ? "#3498db" : "#3498db") : "#999999"
                }
            }

            onCheckedChanged: {
                if (! checked) {
                    print("GRUB not used")
                } else {
                    print("GRUB")
                    config.packageChoice = "grub"
                }
            }
        }
    }

    Rectangle {
        width: 700
        height: 90
        color: "#1b1e20"
        radius: 5
        border.width: 1
        border.color: "#646b75"
        Text {
            width: 600
            height: 40
            x: 25
            y: 10
            text: qsTr("<strong>Refind</strong>: a UEFI bootloader designed to be platform-neutral and to simplify booting multiple operating systems.")
            font.pointSize: 12
            color: "#ffffff"
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -20.0
            wrapMode: Text.WordWrap
        }

        Switch {
            id: refind_switch
            x: 500
            y: 65
            width: 187
            height: 14
            text: qsTr("Refind")
            checked: false
            hoverEnabled: true
            ButtonGroup.group: switchGroup

            indicator: Rectangle {
                implicitWidth: 40
                implicitHeight: 14
                radius: 10
                color: refind_switch.checked ? "#3498db" : "#B9B9B9"
                border.color: refind_switch.checked ? "#3498db" : "#cccccc"

                Rectangle {
                    x: refind_switch.checked ? parent.width - width : 0
                    y: (parent.height - height) / 2
                    width: 20
                    height: 20
                    radius: 10
                    color: refind_switch.down ? "#cccccc" : "#ffffff"
                    border.color: refind_switch.checked ? (refind_switch.down ? "#3498db" : "#3498db") : "#999999"
                }
            }

            onCheckedChanged: {
                if (! checked) {
                    print("refind not used")
                } else {
                    config.packageChoice = "refind"
                    print(config.packageChoice)
                }
            }
        }
    }

    Rectangle {
        width: 700
        height: 90
        color: "#1b1e20"
        radius: 5
        border.width: 1
        border.color: "#646b75"
        Text {
            width: 600
            height: 40
            x: 25
            y: 10
            text: qsTr("<strong>No Bootloader</strong>: Not selecting a bootloader might result in an <strong>un-bootable system</strong>. Only choose this option if you already have a bootloader from another installation.")
            font.pointSize: 12
            color: "#ffffff"
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -20.0
            wrapMode: Text.WordWrap
        }

        Switch {
            id: no_bootloader_switch
            x: 500
            y: 65
            width: 187
            height: 14
            text: qsTr("No bootloader")
            checked: false
            hoverEnabled: true
            ButtonGroup.group: switchGroup

            indicator: Rectangle {
                implicitWidth: 40
                implicitHeight: 14
                radius: 10
                color: no_bootloader_switch.checked ? "#ff8585" : "#B9B9B9"
                border.color: no_bootloader_switch.checked ? "#ff8585" : "#cccccc"

                Rectangle {
                    x: no_bootloader_switch.checked ? parent.width - width : 0
                    y: (parent.height - height) / 2
                    width: 20
                    height: 20
                    radius: 10
                    color: no_bootloader_switch.down ? "#cccccc" : "#ffffff"
                    border.color: no_bootloader_switch.checked ? (no_bootloader_switch.down ? "#ff8585" : "#ff8585") : "#999999"
                }
            }

            onCheckedChanged: {
                if (! checked) {
                    print("no bootloader not checked")
                } else {
                    print("no bootloader")
                    config.packageChoice = "none"
                }
            }
        }
    }
}
