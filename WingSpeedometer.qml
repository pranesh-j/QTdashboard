import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

Item {
    id: root
    property real speed: 113
    property int displaySpeed: Math.round(speed)
    property int maxSpeed: 200
    property real speedPercent: speed / maxSpeed

    // Timer for speed updates
    Timer {
        id: speedTimer
        interval: 3000 // Update every 3 seconds
        running: true
        repeat: true
        onTriggered: {
            // Generate random speed between 0 and maxSpeed
            var newSpeed = Math.floor(Math.random() * (maxSpeed - 30)) + 30
            root.speed = newSpeed
        }
    }

    // Outer ticks
    Canvas {
        id: tickCanvas
        anchors.fill: parent
        antialiasing: true
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(width, height) / 2 - 10;

            ctx.strokeStyle = "#334155";
            ctx.lineWidth = 2;

            // Draw 60 tick marks
            for(var i = 0; i < 60; i++) {
                var angle = (i * 6 - 90) * Math.PI / 180;
                var startRadius = radius - (i % 5 === 0 ? 15 : 10);
                var endRadius = radius;

                ctx.beginPath();
                ctx.moveTo(
                    centerX + startRadius * Math.cos(angle),
                    centerY + startRadius * Math.sin(angle)
                );
                ctx.lineTo(
                    centerX + endRadius * Math.cos(angle),
                    centerY + endRadius * Math.sin(angle)
                );
                ctx.stroke();
            }
        }
    }

    // Speed indicator rings
    Shape {
        id: speedRing
        anchors.fill: parent
        antialiasing: true

        // Background ring
        ShapePath {
            id: backgroundPath
            strokeColor: "#1e293b"
            fillColor: "transparent"
            strokeWidth: 20
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: speedRing.width/2
                centerY: speedRing.height/2
                radiusX: Math.min(speedRing.width, speedRing.height)/2 - 40
                radiusY: Math.min(speedRing.width, speedRing.height)/2 - 40
                startAngle: -180
                sweepAngle: 180
            }
        }

        // Speed indicator ring
        ShapePath {
            id: speedPath
            strokeColor: "#2dd4bf"
            fillColor: "transparent"
            strokeWidth: 20
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: speedRing.width/2
                centerY: speedRing.height/2
                radiusX: Math.min(speedRing.width, speedRing.height)/2 - 40
                radiusY: Math.min(speedRing.width, speedRing.height)/2 - 40
                startAngle: -180
                sweepAngle: root.speedPercent * 180
            }
        }
    }

    // Inner circle background
    Rectangle {
        id: innerCircle
        anchors.centerIn: parent
        width: parent.width * 0.4
        height: width
        radius: width/2
        color: "#0f172a"
        border.color: "#1e293b"
        border.width: 2
    }

    // Speed display
    Column {
        anchors.centerIn: parent
        spacing: 0

        Text {
            id: speedText
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.displaySpeed.toString()
            font {
                pixelSize: root.width * 0.15
                bold: true
                family: "Arial"
            }
            color: "#ffffff"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "KM/H"
            font {
                pixelSize: root.width * 0.05
                bold: false
                family: "Arial"
            }
            color: "#64748b"
        }
    }

    // Top indicator
    Rectangle {
        id: topIndicator
        width: 12
        height: 8
        color: "#2dd4bf"
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: -4
        }
        rotation: 180
        antialiasing: true

        Rectangle {
            width: parent.width
            height: parent.height
            rotation: 180
            color: parent.color
            antialiasing: true
        }
    }

    // Smooth speed transitions
    Behavior on speed {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.OutCubic
        }
    }

    Behavior on speedPercent {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.OutCubic
        }
    }
}
