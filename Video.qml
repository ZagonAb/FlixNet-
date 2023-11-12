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

        onStatusChanged: {
            if (status == MediaPlayer.Loaded) {
                // Ajustar el tamaño del video cuando se carga
                vid.width = vid.height * videoWidth / videoHeight;
            }
        }

        onStopped: {
            if (vid.position === vid.duration) {
                // Mostrar captura de pantalla cuando el video termina
                screenshotImg.source = (game && game.assets.screenshots[0]) || "";
                videoEnded = true;
            }
        }

        onPositionChanged: {
            if (videoEnded && vid.position < vid.duration) {
                // Ocultar la captura de pantalla cuando el video vuelve a reproducirse
                screenshotImg.source = "";
                videoEnded = false;
            }
        }
    }

    Image {
        id: screenshotImg
        anchors.fill: vid

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

    // Cambiar la fuente del video y restablecer la captura de pantalla cuando cambia el juego
    onGameChanged: {
        vid.source = game.assets.video || "";
        screenshotImg.source = "";
        videoEnded = false;
    }
}
