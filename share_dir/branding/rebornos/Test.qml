#!/usr/bin/env qml

import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    width: 800
    height: 800

    Rectangle {
        id: rectangle
        color: "#f2f2f2"
        anchors.fill: parent
        ColumnLayout {
            spacing: 10
            anchors.fill: parent
            Text {
                id: description_text
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
                Layout.topMargin: 10
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                fontSizeMode: Text.Fit
                wrapMode: Text.Wrap
                text: qsTr("Please select a as/kldnkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjkajbslckjalkjsbldajhldksjhdalkjhdlakjshdlakjsdhlkajsdhlkajshdlkajshdlkjshdlkajshdlakjshdlkajsdhlakshddesktop")
                font.pixelSize: 12
            }
            Rectangle {
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.left: parent.left
                anchors.right: parent.right
                //                height: childrenRect.height < 150? 150 :  childrenRect.height + 20
                height: 150
                //                        Layout.fillHeight: true
                //                        Layout.fillWidth: true
                color: "#ffffff"
                radius: 10
                border.width: 0
                ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.leftMargin: 5
                    Layout.rightMargin: 5
                    Layout.bottomMargin: 10
                    Layout.minimumWidth: 150
                    clip: true
                    spacing: 10
                    ScrollBar.vertical: ScrollBar {
                        active: hovered || pressed
                    }
                    model: ListModel {
                        ListElement {
                            name: "Grey"
                            colorCode: "grey"
                        }

                        ListElement {
                            name: "Red"
                            colorCode: "red"
                        }

                        ListElement {
                            name: "Blue"
                            colorCode: "blue"
                        }

                        ListElement {
                            name: "Green"
                            colorCode: "green"
                        }

                        ListElement {
                            name: "Blue"
                            colorCode: "blue"
                        }

                        ListElement {
                            name: "Yellow"
                            colorCode: "yellow"
                        }

                        ListElement {
                            name: "Purple"
                            colorCode: "purple"
                        }
                    }
                    delegate: Rectangle {
                        id: rectangle
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: column.implicitHeight + 20
                        //                        Layout.fillHeight: true
                        //                        Layout.fillWidth: true
                        color: "#fffff0"
                        radius: 10
                        border.width: 0
                        Column{
                            id: column
                            spacing: 10
                            anchors.topMargin: 10
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            anchors.fill: parent
                            Text {
                                anchors.leftMargin: 10
                                width: parent.width - 30
                                wrapMode: Text.Wrap
                                text: qsTr("Gnome")
                                font.pixelSize: 16
                                font.bold: true
                            }
                            Row{
                                id: row
                                anchors.left: parent.left
                                anchors.right: parent.right
                                spacing: 10
                                Image {
                                    anchors.leftMargin: 10
                                    source: "file:images/desktops/budgie.png"
                                    fillMode: Image.PreserveAspectFit
                                    width: (parent.width - 30) / 3
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            image_source = "file:images/desktops/budgie.png"
                                            popup.open()
                                        }
                                    }
                                }
                                Text {
                                    width: (parent.width - 30) * 2/3
                                    anchors.rightMargin: 10
                                    wrapMode: Text.Wrap
                                    text: qsTr("GNOME (/ɡəˈnoʊm, ˈnoʊm/)[7][8] is a free and open-source desktop environment for Unix-like[9] operating systems. GNOME was originally an acronym for GNU Network Object Model Environment, but the acronym was dropped because it no longer reflected the vision of the GNOME project.[10][better source needed].

                GNOME is developed by The GNOME Project, which is composed of both volunteers and paid contributors, the largest corporate contributor being Red Hat.[11][12] It is an international project that aims to develop software frameworks for the development of software, to program end-user applications based on these frameworks, and to coordinate efforts for internationalization and localization and accessibility of that software.

                GNOME 3 is the default desktop environment on many major Linux distributions including Fedora, Debian, Ubuntu, SUSE Linux Enterprise, Red Hat Enterprise Linux, CentOS, Pop!_OS, Oracle Linux, Endless OS, and Tails; as well as Solaris, a Unix operating system. The continued fork of the last GNOME 2 release, called MATE, is default on many Linux distros that target low usage of system resources.")
                                    font.pixelSize: 14
                                }
                            }
                            Switch {
                                anchors.right: parent.right
                                //            text: qsTr("Minimal Install")
                                //            checked: false
                                hoverEnabled: true
                                //            onCheckedChanged: {
                                //                if ( ! checked ) {
                                //                    print("M not used")
                                //                }
                                //                else {
                                //                    print("minimal")
                                //                    config.pkgc = "minimal_install"
                                //                }
                                //            }
                            }
                        }
                    }
                }
            }
        }
    }
}
