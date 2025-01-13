import QtQuick
import QtQuick.Controls

Item {
    id: root
    property int speed: 102
    property int maxSpeed: 180

    // Speedometer Circle
    Canvas {
        id: speedometerCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext('2d');
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(width, height) / 2 - 20;

            // Clear canvas
            ctx.clearRect(0, 0, width, height);

            // Draw outer circle
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
            ctx.strokeStyle = '#2dd4bf';
            ctx.lineWidth = 2;
            ctx.stroke();

            // Draw speed markers
            for (var i = 0; i <= maxSpeed; i += 20) {
                var angle = (i / maxSpeed) * Math.PI * 1.5 - Math.PI * 0.75;
                var markerLength = (i % 40 === 0) ? 15 : 8;
                
                var startX = centerX + (radius - markerLength) * Math.cos(angle);
                var startY = centerY + (radius - markerLength) * Math.sin(angle);
                var endX = centerX + radius * Math.cos(angle);
                var endY = centerY + radius * Math.sin(angle);

                ctx.beginPath();
                ctx.moveTo(startX, startY);
                ctx.lineTo(endX, endY);
                ctx.strokeStyle = '#2dd4bf';
                ctx.lineWidth = (i % 40 === 0) ? 2 : 1;
                ctx.stroke();

                if (i % 40 === 0) {
                    ctx.fillStyle = '#2dd4bf';
                    ctx.font = '14px sans-serif';
                    ctx.textAlign = 'center';
                    ctx.textBaseline = 'middle';
                    var textX = centerX + (radius - 30) * Math.cos(angle);
                    var textY = centerY + (radius - 30) * Math.sin(angle);
                    ctx.fillText(i.toString(), textX, textY);
                }
            }

            // Draw speed needle
            var speedAngle = (speed / maxSpeed) * Math.PI * 1.5 - Math.PI * 0.75;
            ctx.beginPath();
            ctx.moveTo(centerX, centerY);
            ctx.lineTo(
                centerX + (radius - 20) * Math.cos(speedAngle),
                centerY + (radius - 20) * Math.sin(speedAngle)
            );
            ctx.strokeStyle = '#ef4444';
            ctx.lineWidth = 3;
            ctx.stroke();

            // Draw center circle
            ctx.beginPath();
            ctx.arc(centerX, centerY, 10, 0, Math.PI * 2);
            ctx.fillStyle = '#ef4444';
            ctx.fill();
        }
    }

    // Speed Display
    Column {
        anchors.centerIn: parent
        spacing: 8

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.speed
            color: "white"
            font {
                pixelSize: 140
                weight: Font.Light
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "KM/H"
            color: "#4a5568"
            font.pixelSize: 24
        }
    }

    // Audio Visualizer
    Row {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.verticalCenter
            topMargin: 100
        }
        spacing: 2

        Repeater {
            model: 15
            Rectangle {
                width: 3
                height: 5 + Math.random() * 15
                color: "#2dd4bf"
                opacity: 0.5

                SequentialAnimation on height {
                    loops: Animation.Infinite
                    NumberAnimation {
                        to: 5 + Math.random() * 15
                        duration: 500 + Math.random() * 500
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        to: 5 + Math.random() * 15
                        duration: 500 + Math.random() * 500
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }

    // Update speedometer when speed changes
    onSpeedChanged: speedometerCanvas.requestPaint()
}
