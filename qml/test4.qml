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
            displayedEntryScreenshot: "/media/DATA/Development/RebornOS Labs/calamares-branding/branding/rebornos/images/desktops/gnome.png"
            // displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "KDE Plasma"
            displayedEntryDescription: "KDE Plasma a graphical workspaces environment created by KDE primarily for Linux systems. The graphical interface was fully migrated to QML, which uses OpenGL for hardware acceleration, which resulted in better performance and reduced power consumption."
            displayedEntryScreenshot: "/media/DATA/Development/RebornOS Labs/calamares-branding/branding/rebornos/images/desktops/plasma.png"
            // displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Budgie"
            displayedEntryDescription: "Budgie is a desktop environment that uses GNOME technologies such as GTK (> 3.x) and is developed by the Solus project as well as by contributors from numerous communities such as Arch Linux, Manjaro, openSUSE Tumbleweed and Ubuntu Budgie. Budgie's design emphasizes simplicity, minimalism and elegance."
            displayedEntryScreenshot: "/media/DATA/Development/RebornOS Labs/calamares-branding/branding/rebornos/images/desktops/budgie.png"
            // displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Cinnamon"
            displayedEntryDescription: "This is cinnamon"
            displayedEntryScreenshot: "/media/DATA/Development/RebornOS Labs/calamares-branding/branding/rebornos/images/desktops/cinnamon.png"
            // displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
        ListElement {
            displayedEntryName: "Cutefish"
            displayedEntryDescription: "Cutefish desktop environment is an efficient, beautiful, and modern desktop environment with a focus on simple design to be suitable for most users."
            displayedEntryScreenshot: "/media/DATA/Development/RebornOS Labs/calamares-branding/branding/rebornos/images/desktops/cutefish.png"
            // displayedEntryScreenshot: ""
            displayedEntrySelectedState: false
        }
    }
    Rectangle {
        id: page
        color: "#f2f2f2"
        anchors.fill: parent
        Column{
            spacing: 10
            anchors.topMargin: 10
            anchors.fill: parent
            Text {
                anchors.leftMargin: 10
                x: 10
                id: description_text
                wrapMode: Text.Wrap
                text: "Please select the desktop environments to install. Not selecting one will give you a text console and not a graphical user interface. However, installing multiple desktop environments may interfere with each other and cause visual artifacts."
                font.pixelSize: 14
                width: parent.width - 20
            }
            ListView {
                id: listView
                anchors.left: parent.left
                anchors.right: parent.right
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
    }
    Popup {
        id: popup
        width: {
            if (image_width > image_height || image_width < 2){
                page.width - 50
            } else {
                (page.height - 50) * image_width / image_height
                // if (new_width >= page.width - 50) {
                //     page.width - 50
                // }
            } 
        }
        height: {
            if (image_height > image_width || image_height < 2){
                page.height - 50
            } else {
                (page.width - 50) * image_height / image_width
                // if (new_height >= page.height - 50) {
                //     page.height - 50
                // }
            } 
        }
        anchors.centerIn: parent
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnReleaseOutside | Popup.CloseOnReleaseInside
        padding: 0
        // onAboutToShow: {
        //     image_width= enlarged_image.paintedWidth
        //     image_height= enlarged_image.paintedHeight
        // }
        onOpened: {
            image_width= enlarged_image.paintedWidth
            image_height= enlarged_image.paintedHeight
        }
        contentItem:
            Image{
                id: enlarged_image
                fillMode: Image.PreserveAspectFit
                source: image_source
                onStatusChanged: {
                    image_width= enlarged_image.paintedWidth
                    image_height= enlarged_image.paintedHeight
                }
            }
    }
}
