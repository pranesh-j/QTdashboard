import QtQuick
import QtQuick.Controls

Item {
    id: root
    height: 40
    property string currentMode: "eco"

    Row {
        anchors.centerIn: parent
        spacing: 32

        Repeater {
            model: ["ECO", "SPORT", "DAILY"]
            Text {
                text: modelData
                color: root.currentMode.toLowerCase() === modelData.toLowerCase() ? "#2dd4bf" : "#4a5568"
                font.pixelSize: 24
                font.weight: root.currentMode.toLowerCase() === modelData.toLowerCase() ? Font.DemiBold : Font.Normal

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.currentMode = modelData.toLowerCase()
                    cursorShape: Qt.PointingHandCursor
                }

                // Underline for active mode
                Rectangle {
                    visible: root.currentMode.toLowerCase() === modelData.toLowerCase()
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: 4
                    width: parent.width
                    height: 2
                    color: "#2dd4bf"
                }
            }
        }
    }
}
