import QtQuick 2.0

Rectangle {
    id: rectangle1
        color: "#373737"
        border.width: 0
    width: 400
    height: 8

    Rectangle {
        id: rectangle
        x: 192
        y: 0
        width: 100
        height: 5
        color: "white"
        radius: 2.5
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }


}
