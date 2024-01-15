// Pegasus Frontend - Flixnet-Plus theme
// Copyright (C) 2022 Gonzalo Abbate
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.7
import QtMultimedia 5.7
import QtGraphicalEffects 1.0

Item {
    property var game: null
    property bool videoEnded: false
    property alias screenshot: screenshotImg.source

    width: vid.width
    height: vid.height
    visible: game

    Video {

        id: vid
        anchors.fill: parent 
        source: game.assets.video || ""
        fillMode: VideoOutput.Stretch
        autoPlay: true
        visible: true
        opacity: 1.5

        onStatusChanged: {
            if (status === MediaPlayer.Loaded) {
                vid.width = vid.height * videoWidth / videoHeight;
                player.play();
            }
        }

        onStopped: {
            if (vid.position === vid.duration) {
                screenshotImg.source = (game && game.assets.screenshots[0]) || "";
                videoEnded = true;
            }
        }

        onPositionChanged: {
            if (videoEnded && vid.position < vid.duration) {
                screenshotImg.source = "";
                videoEnded = false;
            }
        }
    }

        Image {
            anchors.fill: parent
            source: "assets/crt.png" // Ruta de la imagen de las líneas de exploración
            fillMode: Image.Tile
            visible: true
            opacity: 0.2 // Cambiar la opacidad de las líneas de exploración para hacer el video más visible
        }

    Image {
        id: screenshotImg
        anchors.fill: parent
        visible: videoEnded

        LinearGradient {
            id: screenshotGrad
            width: parent.width
            height: labelHeight * 0.5
            visible: false
            anchors.bottom: screenshotImg.bottom
            anchors.right: screenshotImg.right
            start: Qt.point(0, height)
            end: Qt.point(0, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FF000000" }
                GradientStop { position: 1.0; color: "#00000000" }
            }
        }

        LinearGradient {
            width: screenshotImg.width * 0.5
            height: screenshotImg.height
            anchors.left: screenshotImg.left
            start: Qt.point(0, 0)
            end: Qt.point(width, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FF000000" }
                GradientStop { position: 1.0; color: "#00000000" }
            }
        }
    }

    Image {
        anchors.fill: vid
        source: "assets/crt.png"
        fillMode: Image.Tile
        visible: videoEnded
        opacity: 0.2
    }

    LinearGradient {
        width: vid.width
        height: labelHeight * 0.50

        anchors.bottom: vid.bottom
        anchors.right: vid.right

        start: Qt.point(0, height)
        end: Qt.point(0, 0)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FF000000" }
            GradientStop { position: 1.0; color: "#00000000" }
        }
    }


    LinearGradient {
        width: vid.width * 0.75
        height: vid.height

        anchors.left: vid.left

        start: Qt.point(0, 0)
        end: Qt.point(width, 0)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FF000000" }
            GradientStop { position: 1.0; color: "#00000000" }
        }
    }

    onGameChanged: {
        vid.source = game.assets.video || "";
        screenshotImg.source = "";
        videoEnded = false;
    }
}
