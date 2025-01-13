import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects

Window {
    id: root
    width: 1280
    height: 800
    visible: true
    color: "#0a1929"
    title: "Electric Scooter Dashboard"

    // Properties
    property int currentSpeed: 102
    property int batteryLevel: 72
    property int range: 136
    property string currentDate: "January 10, 2025"
    property string currentTime: "11:07 PM"
    property string activeNavItem: "home"
    property string currentMode: "eco"

    // Add glow effect component
    Component {
        id: iconGlow
        Rectangle {
            color: "#2dd4bf"
            radius: width
            opacity: 0
            scale: 1.2
            Behavior on opacity {
                NumberAnimation { duration: 200 }
            }
        }
    }

    // Top Bar
    Rectangle {
        id: topBar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 60
        color: "transparent"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 32

            Text {
                text: root.currentDate
                color: "white"
                font.pixelSize: 18
            }

            Row {
                Layout.alignment: Qt.AlignCenter
                spacing: 24
                Repeater {
                    model: ["chevron-left", "menu", "user", "power", "menu", "chevron-right"]
                    Item {
                        width: 32
                        height: 32
                        
                        Image {
                            id: icon
                            anchors.centerIn: parent
                            source: "icons/" + modelData + ".svg"
                            width: 32
                            height: 32
                            opacity: 1
                            layer.enabled: true
                            layer.effect: ColorOverlay {
                                color: modelData === "power" ? "#ef4444" :
                                       modelData === "user" ? "#3b82f6" : "#ffffff"
                            }

                            Loader {
                                id: glowLoader
                                anchors.fill: parent
                                sourceComponent: iconGlow
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onEntered: {
                                icon.scale = 1.1
                                glowLoader.item.opacity = 0.3
                            }
                            onExited: {
                                icon.scale = 1.0
                                glowLoader.item.opacity = 0
                            }
                            onPressed: {
                                icon.scale = 0.9
                                glowLoader.item.opacity = 0.5
                            }
                            onReleased: {
                                icon.scale = 1.0
                                glowLoader.item.opacity = 0.3
                            }
                        }

                        Behavior on scale {
                            NumberAnimation { duration: 100 }
                        }
                    }
                }
            }

            Row {
                Layout.alignment: Qt.AlignRight
                spacing: 16

                Image {
                    source: "icons/signal.svg"
                    width: 18
                    height: 18
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: "#ffffff"
                    }
                }

                Image {
                    source: "icons/bluetooth.svg"
                    width: 18
                    height: 18
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: "#ffffff"
                    }
                }

                Text {
                    text: root.currentTime
                    color: "white"
                    font.pixelSize: 18
                }
            }
        }
    }

    // Mode Selector
    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: topBar.bottom
        anchors.topMargin: 20
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

    // Main Content
    Item {
        anchors {
            top: topBar.bottom
            left: parent.left
            right: parent.right
            bottom: bottomBar.top
        }

        NavigationLine {
            id: navLine
            anchors {
                left: parent.left
                leftMargin: 48
                top: parent.top
                bottom: parent.bottom
            }
            width: 96
        }

        // Futuristic Speedometer
        Item {
            id: speedometer
            anchors.centerIn: parent
            width: 300
            height: 300

            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext('2d');
                    ctx.clearRect(0, 0, width, height);
                    ctx.beginPath();
                    ctx.arc(width / 2, height / 2, 140, 0, Math.PI * 2);
                    ctx.strokeStyle = '#2dd4bf';
                    ctx.lineWidth = 5;
                    ctx.stroke();

                    // Needle
                    ctx.beginPath();
                    ctx.moveTo(width / 2, height / 2);
                    var angle = (root.currentSpeed / 180) * Math.PI * 2;
                    ctx.lineTo(width / 2 + 120 * Math.cos(angle - Math.PI / 2), height / 2 + 120 * Math.sin(angle - Math.PI / 2));
                    ctx.strokeStyle = '#ef4444';
                    ctx.lineWidth = 3;
                    ctx.stroke();
                }
            }
        }

        InfoPanel {
            anchors {
                right: parent.right
                rightMargin: 48
                top: parent.top
                topMargin: parent.height * 0.2
            }
            width: 200
        }
    }

    // Bottom Navigation Bar
    Rectangle {
        id: bottomBar
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 100
        color: "transparent"

        ColumnLayout {
            anchors {
                fill: parent
                margins: 24
            }
            spacing: 16

            // Navigation Icons
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 48
                Repeater {
                    model: ["home", "map", "phone", "music", "settings"]
                    Item {
                        width: 32
                        height: 32
                        
                        Image {
                            id: navIcon
                            anchors.centerIn: parent
                            source: "icons/" + modelData + ".svg"
                            width: 32
                            height: 32
                            opacity: modelData === root.activeNavItem ? 1 : 0.7
                            layer.enabled: true
                            layer.effect: ColorOverlay {
                                color: "#ffffff"
                            }

                            Loader {
                                id: navGlowLoader
                                anchors.fill: parent
                                sourceComponent: iconGlow
                                opacity: modelData === root.activeNavItem ? 0.3 : 0
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onEntered: {
                                navIcon.scale = 1.1
                                navGlowLoader.item.opacity = 0.3
                            }
                            onExited: {
                                navIcon.scale = 1.0
                                navGlowLoader.item.opacity = modelData === root.activeNavItem ? 0.3 : 0
                            }
                            onClicked: {
                                root.activeNavItem = modelData
                                navIcon.scale = 1.0
                            }
                        }

                        SequentialAnimation on scale {
                            running: modelData === root.activeNavItem
                            loops: Animation.Infinite
                            NumberAnimation { to: 1.1; duration: 1000; easing.type: Easing.InOutQuad }
                            NumberAnimation { to: 1.0; duration: 1000; easing.type: Easing.InOutQuad }
                        }
                    }
                }
            }

            // Battery/Range Bar
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: root.batteryLevel + "% Battery"
                    color: "#2dd4bf"
                    font.pixelSize: 14
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 4
                    color: "#374151"
                    radius: 2

                    Rectangle {
                        width: parent.width * (root.batteryLevel / 100)
                        height: parent.height
                        radius: 2

                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#eab308" }
                            GradientStop { position: 0.3; color: "#22c55e" }
                            GradientStop { position: 1.0; color: "#2dd4bf" }
                        }

                        Behavior on width {
                            NumberAnimation { duration: 1000 }
                        }
                    }
                }

                Text {
                    text: root.range + "KM Range"
                    color: "#2dd4bf"
                    font.pixelSize: 14
                }
            }
        }
    }
}
