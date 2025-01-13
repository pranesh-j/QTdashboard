import QtQuick
import QtQuick.Controls

Item {
    id: root
    property int speed: 113
    property int maxSpeed: 200

    // Dynamic Speed Display
    Column {
        anchors.centerIn: parent
        spacing: 10
        width: parent.width

        Text {
            text: Math.round(speed)
            font.pixelSize: 80
            font.bold: true
            color: "#ffffff"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Text {
            text: "KM/H"
            font.pixelSize: 24
            color: "#888888"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }

    // Animation when speed changes
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            speed = Math.floor(Math.random() * maxSpeed);
        }
    }
}
