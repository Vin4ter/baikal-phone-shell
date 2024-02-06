import QtQuick 2.14
import QtQuick.LocalStorage 2.14
import "../utils/utils.js" as Utils
import "../utils/settings.js" as Settings

Item {
    id: lockscreen
    StatusBar {
        id: statusbar
    }
    Image {
        Component.onCompleted: {
            Settings.getDatabase()
            Utils.handle_battery_monitor(statusbar.battery_container, statusbar.battery_level)
        }
        id: lockscreen_image
        width: root.width
        height: root.height
        visible: true

            source: "../icons/baikal.jpg"
            sourceSize.height: 1920
            sourceSize.width: 1080

            fillMode: Image.PreserveAspectCrop
    }
    Component.onCompleted: {
        console.log("rrrt!")
    }

    Text {
        id: lockscreen_time
        text: Qt.formatDateTime(new Date(), "HH:mm")
        color: 'white'
        font.pixelSize: (parent.height / 30) * 1
        anchors {
            left: parent.left
            bottom: lockscreen_date.top
            leftMargin: (parent.height / 26) * 1
        }
    }
    Text {
        id: lockscreen_date
        text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
        color: 'white'
        font.pixelSize: (parent.height / 50) * 1
        anchors {
            left: parent.left
            bottom: parent.bottom
            margins: (parent.height / 26) * 1
        }
    }
    Timer {
        repeat: (state_handler.state === "locked") ? true : false
        interval: 1000
        running: true
        onTriggered: {
            lockscreen_time.text = Qt.formatDateTime(new Date(), "HH:mm");
            lockscreen_date.text = Qt.formatDateTime(new Date(), "dddd, MMMM d");
        }
    }
    MouseArea {
        id: lockscreen_mouse_area
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

    Timer {
        repeat: true
        interval: 1000
        running: true
        onTriggered: {
            Utils.handle_battery_monitor(statusbar.battery_container, statusbar.battery_level)
        }
    }
}

