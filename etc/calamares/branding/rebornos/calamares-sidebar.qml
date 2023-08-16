/* Sample of QML progress tree.

   SPDX-FileCopyrightText: 2020 Adriaan de Groot <groot@kde.org>
   SPDX-FileCopyrightText: 2021 Anke Boersma <demm@kaosx.us>
   SPDX-License-Identifier: GPL-3.0-or-later


   The progress tree (actually a list) is generally "vertical" in layout,
   with the steps going "down", but it could also be a more compact
   horizontal layout with suitable branding settings.

   This example emulates the layout and size of the widgets progress tree.
*/

import io.calamares.ui 1.0
import io.calamares.core 1.0

import QtQuick 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15

Rectangle {
    id: sideBar;
    color: Branding.styleString( Branding.SidebarBackground );
    height: 46;
    width: parent.width;

    RowLayout {
        anchors.fill: parent;
        
        Image {
            Layout.leftMargin: 9;
            Layout.rightMargin: 12;
            Layout.bottomMargin: 3;	
            Layout.alignment: Qt.AlignCenter;
            id: logo;
            width: 40;
            height: width;  // square
            source: "file:/" + Branding.imagePath(Branding.ProductLogo);
            sourceSize.width: width;
            sourceSize.height: height;
        }

        Repeater {
            model: ViewManager
            Rectangle {
                Layout.leftMargin: 6;
                Layout.rightMargin: 6;
                Layout.bottomMargin: 3;
                Layout.fillWidth: true;
                Layout.alignment: Qt.AlignCenter;
                height: 32;
                radius: 6;
                color: Branding.styleString( index == ViewManager.currentStepIndex ? Branding.SidebarBackgroundCurrent : Branding.SidebarBackground );

                Text {
                    horizontalAlignment: Text.AlignHCenter; 
                    verticalAlignment: Text.AlignVCenter; 
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    x: parent.x + 12;
                    color: Branding.styleString( index == ViewManager.currentStepIndex ? Branding.SidebarTextCurrent : Branding.SidebarText );
                    
                    text: display;
                    width: parent.width;
                    wrapMode: Text.WordWrap;
                    font.weight: (index == ViewManager.currentStepIndex ? Font.Bold : Font.Normal);
                    font.pointSize : (index == ViewManager.currentStepIndex ? 10 : 9);
                }
            }
        }
    }
}
