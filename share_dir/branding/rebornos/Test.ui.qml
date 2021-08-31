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
                text: qsTr("Please select a desktop")
                font.pixelSize: 12
            }
            ListView {
                id: listView
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                Layout.bottomMargin: 10
                Layout.minimumWidth: 150
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
                    anchors.margins: 10
                    width: parent.width
                    height: 150
                    color: "#ffffff"
                    radius: 10
                    border.width: 0
                }
            }
        }
    }
}
