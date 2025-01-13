import QtQuick

Rectangle {
    id: overlay
    property alias source: mask.source
    color: "#2dd4bf"

    Image {
        id: mask
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    Rectangle {
        anchors.fill: parent
        color: parent.color
        opacity: 0.7
        visible: true
        layer.enabled: true
        layer.samplerName: "maskSource"
        layer.effect: null
        layer.smooth: true
    }
}

