import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
id: settingSheet
width: 480
height: 800

color: "#3c3b3b"

MouseArea {
    id: settingSheet_area
    anchors.fill: parent
    drag.target: lockscreen
    drag.axis: Drag.YAxis
    drag.maximumY: 0
    onReleased: {
        if(lockscreen.y > -root.height / 2) {
            bounce.restart()
        } else {
            slide.start()
            state_handler.state = "normal"
        }
    }
}

NumberAnimation {
    id: slide
    target: lockscreen
    properties: "y"
    to: -root.height
    easing.type: Easing.OutQuad
    duration: 200
}

NumberAnimation {
    id: bounce
    target: lockscreen
    properties: "y"
    to: 0
    easing.type: Easing.InOutQuad
    duration: 200
}
}
