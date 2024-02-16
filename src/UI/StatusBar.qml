import QtQuick 2.14
import QtQuick.LocalStorage 2.14
import "../utils/settings.js" as Settings

Rectangle {
    id: rectangle
    property alias battery_container: battery_container
    property alias battery_percentage: battery_percentage
    property alias battery_level: battery_level
    property alias wlanIndicator: wlanIndicator
    width: 480
    height: 25
    color: "#373737"
    Component.onCompleted: {
        Settings.getDatabase()
        battery_percentage.text = battery_handler.battery_level() + "%"
    }

    anchors {
        top: parent.top
    }
    MouseArea {
        anchors.fill: parent

        drag.target: settingSheet; drag.axis: Drag.YAxis; drag.minimumY: -root.height+statusbar.height; drag.maximumY: 0
        //onPressAndHold: {
        //    screenshotTimer.start();
        // slide.start
        //}
        //onClicked: {
        //    if (settingSheet.y > -535) {             state_handler.state  = "normal" } else { state_handler.state = "settingSheet" }
        // }
        onPressed: {
            statusbar.opacity = 0
            bgBlur.visible = true

            bgBlur.showOp()
        }

        onReleased: {
            if(settingSheet.y<-root.height+25){
                settingSheet.downUp()
                state_handler.state = "normal"
                bgBlur.hideOp()

            }else{
                settingSheet.showUp()
                state_handler.state = "settingSheet"
                //bgBlur.showOp()
            }
            //   if (settingSheet.y > -535) {  state_handler.state = "settingSheet" } else {    state_handler.state  = "normal"}
        }
    }

    Text {
        id: battery_percentage
        text: "0"
        color: "#ffffff"
        font.pixelSize: parent.height / 2
        anchors {
            verticalCenter: parent.verticalCenter
            right: battery_container.left
            rightMargin: 3
        }
    }





    Image {
        id: wlanIndicator
        x: 436
        width: 48
        anchors.verticalCenter: battery_percentage.verticalCenter
        anchors.right: battery_percentage.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        horizontalAlignment: Image.AlignRight
        sourceSize.height: 64
        sourceSize.width: 64
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        anchors.rightMargin: 6
        /*
        source: if (networkManager.state == "idle") { "../icons/wireless-symbolic.svg" } // no wifi connection
                                else if (networkManager.connected && networkManager.connectedWifi.strength >= 55 ) { "../icons/wireless-60-symbolic.svg" }
                                else if (networkManager.connected && networkManager.connectedWifi.strength >= 50 ) { "../icons/wireless-40-symbolic.svg" }
                                else if (networkManager.connected && networkManager.connectedWifi.strength >= 45 ) { "../icons/wireless-20-symbolic.svg" }
                                else if (networkManager.connected && networkManager.connectedWifi.strength >= 30 ) { "../icons/wireless-0-symbolic.svg" }
                else { ":/icons/wireless-symbolic.svg" }
                                anchors.leftMargin: -38
                                anchors.horizontalCenter: battery_percentage.horizontalCenter
  */

        fillMode: Image.PreserveAspectFit


    }

    Rectangle {
        id: battery_container
        anchors {
            right:  parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 20
        }
        height: clock.height
        width: 8
        color: "#4fffffff"
        Rectangle {
            id: battery_level
            height: 0
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Text {
        visible: true
        id: clock
        width: 100
        color: "#ffffff"
        z: 2000
        text: Qt.formatDateTime(new Date(), "HH:mm")
        Timer {
            repeat: true
            interval: 1000
            running: true
            onTriggered: {
                parent.text = Qt.formatDateTime(new Date(), "HH:mm")
            }
        }
        font.pixelSize: parent.height / 2
        anchors.verticalCenterOffset: 0
        anchors.leftMargin: 20
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left

        }
    }






}

/*##^##
Designer {
    D{i:0;formeditorZoom:6}D{i:3}
}
##^##*/
