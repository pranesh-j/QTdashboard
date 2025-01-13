import QtQuick
import QtQuick.Controls

Item {
    id: root

    Column {
        anchors.right: parent.right
        spacing: 16

        Text {
            text: "Trip A"
            color: "#2dd4bf"
            font.pixelSize: 14
        }

        Text {
            text: "230 Km"
            color: "white"
            font.pixelSize: 24
        }

        Text {
            text: "Odometer"
            color: "#2dd4bf"
            font.pixelSize: 14
        }

        Text {
            text: "2,030 Km"
            color: "white"
            font.pixelSize: 24
        }

        Text {
            text: "Temperature"
            color: "#2dd4bf"
            font.pixelSize: 14
        }

        Text {
            text: "30°F"
            color: "white"
            font.pixelSize: 24
        }
    }
}
