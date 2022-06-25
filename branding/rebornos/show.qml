/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2015 Teo Mrnjavac <teo@kde.org>
 *   SPDX-FileCopyrightText: 2018 Adriaan de Groot <groot@kde.org>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 *   Calamares is Free Software: see the License-Identifier above.
 *
 */

import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    function nextSlide() {
        console.log("QML Component (default slideshow) changing to slide ", presentation.currentSlide + 1);
        presentation.goToNextSlide();
    }

    Timer {
        id: advanceTimer
        interval: 15000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: nextSlide()
    }

    Slide {
	    anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            border.width: 0
            color: "#EFF0F1"
            Image {
                id: slide_1
                source: "images/slides/slide_1.jpg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
        }
    }

    Slide {
	    anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            border.width: 0
            color: "#EFF0F1"
            Image {
                id: slide_2
                source: "images/slides/slide_2.jpg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
        }
    }

    Slide {
	    anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            border.width: 0
            color: "#EFF0F1"
            Image {
                id: slide_3
                source: "images/slides/slide_3.jpg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
        }
    }

    Slide {
	    anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            border.width: 0
            color: "#EFF0F1"
            Image {
                id: slide_4
                source: "images/slides/slide_4.jpg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
        }
    }

    Slide {
	    anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            border.width: 0
            color: "#EFF0F1"
            Image {
                id: slide_5
                source: "images/slides/slide_5.jpg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
        }
    }

    Slide {
	    anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            border.width: 0
            color: "#EFF0F1"
            Image {
                id: slide_6
                source: "images/slides/slide_6.jpg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
        }
    }

    // When this slideshow is loaded as a V1 slideshow, only
    // activatedInCalamares is set, which starts the timer (see above).
    //
    // In V2, also the onActivate() and onLeave() methods are called.
    // These example functions log a message (and re-start the slides
    // from the first).
    function onActivate() {
        console.log("QML Component (slideshow) activated");
        presentation.currentSlide = 0;
    }

    function onLeave() {
        console.log("QML Component (slideshow) deactivated");
    }

}
