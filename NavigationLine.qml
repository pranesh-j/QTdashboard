import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: root

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 1
        height: parent.height
        color: "#2dd4bf"
        opacity: 0.7
    }

    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.3
        width: 24
        height: 24

        Rectangle {
            id: navigationPoint
            anchors.centerIn: parent
            width: 16
            height: 16
            rotation: 45
            color: "#2dd4bf"
            antialiasing: true

            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation { to: 1; duration: 1000 }
                NumberAnimation { to: 0.3; duration: 1000 }
            }
        }
    }

    Column {
        anchors {
            top: parent.top
            topMargin: parent.height * 0.35
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 12

        Row {
            spacing: 8
            Image {
                source: "icons/clock.svg"
                width: 16
                height: 16
                opacity: 0.7
                layer.enabled: true
                layer.effect: ColorOverlay {
                    color: "#ffffff"
                }
            }
            Text {
                text: "23m Time"
                color: "#2dd4bf"
                opacity: 0.7
                font.pixelSize: 14
            }
        }

        Text {
            text: "1.2km Distance"
            color: "#2dd4bf"
            opacity: 0.7
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }
}
