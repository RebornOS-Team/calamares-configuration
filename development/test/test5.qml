import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    // width: 800
    // height: 800
    property string image_source: ""
    property int image_width: 1
    property int image_height: 1
    ListModel {
        id: displayedEntryModel

        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Gnome"
            displayedEntryDescription: "GNOME (GNU Network Object Model Environment, pronounced gah-NOHM) is a graphical user interface (GUI) and set of computer desktop applications for users of the Linux operating system"
            displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
    }
    ListView {
        id: listView
        anchors.fill: parent
        height: parent.height - 100
        clip: true
        spacing: 10
        // boundsBehavior: Flickable.StopAtBounds
        ScrollBar.vertical: ScrollBar {
            active: hovered || pressed
        }
        model: displayedEntryModel
        delegate: Rectangle {
            id: rectangle
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            x: 10
            //            height: 500
            width: listView.width - 20
            height: column.implicitHeight + 20
            //                        Layout.fillHeight: true
            //                        Layout.fillWidth: true
            color: "#ffffff"
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
                    text: displayedEntryName
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
                        source: displayedEntryScreenshot
                        fillMode: Image.PreserveAspectFit
                        width: (parent.width - 30) / 3
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                image_width = 1
                                image_height = 1
                                image_source = displayedEntryScreenshot
                                popup.open()
                            }
                        }
                    }
                    Text {
                        width: (parent.width - 30) * 2/3
                        anchors.rightMargin: 10
                        wrapMode: Text.Wrap
                        text: displayedEntryDescription
                        font.pixelSize: 14
                    }
                }
                Switch {
                    anchors.right: parent.right
                    checked: displayedEntrySelectedState
                    hoverEnabled: true
                    // onCheckedChanged: {
                    //     if ( checked ) {
                    //         config.addSelection(config.displayedEntryIds[index])
                    //     } else {
                    //         config.removeSelection(config.displayedEntryIds[index])
                    //     }
                    // }
                }                        
            }
        }
    }
}
