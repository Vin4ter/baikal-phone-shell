import QtQuick 2.14
import QtQuick.LocalStorage 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.14
import QtWayland.Compositor 1.14
import Nemo.DBus 2.0

import "../utils/settings.js" as Settings
import "../utils/utils.js" as Utils
import "../UI"

Rectangle {




    property var appPages: []
    property bool md: true //to home true
    property int margin_padding: root.height / (50 * Settings.get("applications_per_row"))
    property alias statusbar: statusbar
     property alias slideLiner: slideLiner
    property alias volume_ui: volumeUi
    width: wayland_window.width
    height: wayland_window.height
    Component.onCompleted: {
        Settings.getDatabase()
        statusbar.battery_percentage.text = battery_handler.battery_level() + "%"
        Utils.handle_battery_monitor(statusbar.battery_container, statusbar.battery_level)

        nm.toggleWifi();
             nm.toggleWifi();
    }

    id: root
    visible: true


    NetworkManager {
          id: nm
          property var networkName: ""


        onCurrentStrengthChanged: {
                 if (nm.networkState == "connected" && nm.currentStrength >= 60)
                          statusbar.wlanIndicator.source ="../icons/wireless-60-symbolic.svg"
                 else if (nm.networkState == "connected" && nm.currentStrength >= 40)
                           statusbar.wlanIndicator.source = "../icons/wireless-40-symbolic.svg"
                 else if (nm.networkState == "connected" && nm.currentStrength >= 20)
                           statusbar.wlanIndicator.source ="../icons/wireless-20-symbolic.svg"
                 else if(nm.networkState == "connected" && nm.currentStrength >= 80)
                            statusbar.wlanIndicator.source = "../icons/wireless-symbolic.svg"
                 else
                            statusbar.wlanIndicator.source = "../icons/wireless-0-symbolic.svg"
             }
        onNetworkStateChanged: {
                       if ((nm.networkState == "connected")) {
                           statusbar.wlanIndicator.visible = true
                                nm.getAPTimer.start()
                                nm.getAPTimer.repeat = true
                                nm.getAPTimer.running = true
                          // statusbar. getAPTimer.visible = true
                                      //getAPTimer.running = true
                       }else{
                           statusbar.wlanIndicator.visible = false
                          nm.getAPTimer.stop()
                           nm.getAPTimer.repeat = false
                           nm.getAPTimer.running = false
                       }
        }
      }





Image {
    id: bg
        width: root.width
        height: root.height - slideLiner.height
        visible: true

            source: "../icons/baikal.jpg"
            sourceSize.height: 1920
            sourceSize.width: 1080

            fillMode: Image.PreserveAspectCrop



      //  color: "black"
        Component.onCompleted: {
            Utils.application_list_refresh(application_list)
        }

        Rectangle {
            color: "transparent"
            visible: (shellSurfaces.count > 0) ? true : false
            id: application_container
            width: parent.width
            height: parent.height - statusbar.height
            y: statusbar.height
            z: (application_container.visible == true) ? 200 : 0
            StackLayout {
                id: application_display
                anchors.fill: parent
                Repeater {
                    id: application_repeater
                    model: shellSurfaces
                    delegate: Loader {
                        source: (modelData.toString().match(/XWaylandShellSurface/)) ? "../../Chromes/XWaylandChrome.qml" : "../../Chromes/WaylandChrome.qml"
                        Component.onCompleted: {
                            application_display.currentIndex = application_display.count - 1
                            application_container.y = statusbar.height
                        }
                        Component.onDestruction: {
                            application_display.currentIndex--
                            if(!shellSurfaces.count > 0) {
                                application_container.visible = false
                            }
                        }
                    }
                }
            }

        }

        SwipeView {
            id: screen_swipe_view
            currentIndex: 1
            anchors.fill: parent
            Item {
                id: information_page
                Text {
                    visible: true
                    text: "Coming soon!"
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    color: "white"
                    font.pixelSize: parent.height / 25 * Settings.get("scaling_factor")
                }
            }
            Item {
                id: app_page


                GridView {
                    id: application_list
                    x: margin_padding

                    width: screen_swipe_view.width - margin_padding
                    height: screen_swipe_view.height - statusbar.height - margin_padding

                    model: appPages[0].length
                    cellWidth: (screen_swipe_view.width - margin_padding) / Settings.get("applications_per_row")
                    cellHeight: (screen_swipe_view.width - margin_padding) / Settings.get("applications_per_row")
                    focus: true
                  //  y: statusbar.height + 5 + searchField.height

                    delegate: Item {
                        Column {
                            id: app_rectangle
                            Rectangle {
                                color: "#00000000"
                                width: application_list.cellWidth - margin_padding
                                height: application_list.cellHeight - margin_padding
                                anchors.horizontalCenter: parent.horizontalCenter

                                Image {
                                    width: app_rectangle.height / 2.5 * Settings.get("scaling_factor")
                                    height: app_rectangle.height / 2.5 * Settings.get("scaling_factor")
                                    id: application_icon
                                    y: 20
                                    source: "image://icons/" + appPages[0][index][1]
                                    anchors {
                                        horizontalCenter: parent.horizontalCenter
                                        verticalCenter: parent.verticalCenter
                                    }
                                }
                                Text {
                                    font.pixelSize: parent.height / 10 * Settings.get("scaling_factor")
                                    text: appPages[0][index][0]
                                    color: "#ffffff"
                                    anchors {
                                        bottom: parent.bottom
                                        horizontalCenter: parent.horizontalCenter
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        application_container.visible = true
                                        proc.start(appPages[0][index][2])
                                    }
                                }
                            }
                        }
                    }
                }
/*
                Rectangle{
                    id: bgSearchField
                    anchors.top: parent.top
              width: root.width
                    anchors.topMargin: 0
                    height: 50 +statusbar.height
                  //  width: 400
                    color: "#373737"
                    TextField {
                           id: searchField
                           text: ""
                           height: 32
                           background: Rectangle{
                               color: "#262627"
                               radius: 15
                           }

                           color: "white"
                  anchors.leftMargin: 0
                  anchors.rightMargin: 0
                          anchors.left: parent.left
                        anchors.right: parent.right
                          // anchors.top: parent.top

                             anchors.verticalCenter: parent.verticalCenter
                           placeholderTextColor: "grey"
                           placeholderText: qsTr("поиск")
                       //    width: root.width * 0.95

                           onTextEdited: {
                            //   refresh()
                           }

                           Keys.onEscapePressed: Qt.quit()
                           Keys.onDownPressed: swipeView.forceActiveFocus()
                           onAccepted: {
                              // var app = swipeView.currentItem.page[0]
                           //    if (app) {
                             //      exec(app[2])
                             //  }
                           }
                       }
                }
*/


            }
            Item {
                id: app_switcher_page
                Text {
                    visible: (shellSurfaces.count === 0)
                    text: "Nothing open yet"
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    color: "#ffffff"
                    opacity: 0.4
                    font.pixelSize: parent.height / 30 * Settings.get("scaling_factor")
                }

                GridView {
                    id: app_switcher_grid
                    x:15 * margin_padding / 2
                    y: statusbar.height + 10 * margin_padding
                    width: parent.width
                    height: parent.height - statusbar.height
                    cellWidth: parent.width / 2
                    cellHeight: parent.height / 2
                    model: shellSurfaces
                    anchors {
                        top: statusbar.bottom
                        topMargin: margin_padding
                    }
                    delegate: Item {
                        width: app_switcher_grid.cellWidth - 15 * margin_padding
                        height: app_switcher_grid.cellHeight - 10 * margin_padding
                        Text {
                            id: app_switcher_title
                            color: "#ffffff"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: app_switcher_surfaceItem.top
                            anchors.bottomMargin: margin_padding
                            text: (modelData.toplevel.title.toString().length > 16) ? modelData.toplevel.title.toString().substring(0,16) + "..." : modelData.toplevel.title
                            font.pixelSize: root.height / 50 * Settings.get("scaling_factor")
                        }

                        ShellSurfaceItem {
                            id: app_switcher_surfaceItem
                            inputEventsEnabled: false
                            shellSurface: modelData
                            width: parent.width * Settings.get("scaling_factor")
                            height: (parent.height - app_switcher_title.height) * Settings.get("scaling_factor")
                            anchors.bottom: parent.bottom
                            sizeFollowsSurface: false
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {

                                    application_display.currentIndex = index
                                    application_container.y = statusbar.height
                                    application_container.visible = true
                                    screen_swipe_view.currentIndex = 1
                                }
                                onPressAndHold: {
                                    modelData.surface.client.close()
                                }
                            }
                        }
                    }
                }
            }

        }




        NumberAnimation {
            id: slide
            target: application_container
            properties: "y"
            to: -root.height
            easing.type: Easing.OutQuad
            duration: 200
            onFinished:  {
                if(md==true){
                         screen_swipe_view.currentIndex = 1
                }else{
                           screen_swipe_view.currentIndex = 2
                }
             }
        }

        NumberAnimation {
            id: bounce
            target: application_container
            properties: "y"
            to: statusbar.height
            easing.type: Easing.OutQuad
            duration: 200


        }

        //battery handler timer
        //TODO better "battery path" handler
        //TODO better battery indicator implementation

        Timer {
            repeat: true
            interval: 1000
            running: true
            onTriggered: {
                statusbar.battery_percentage.text = battery_handler.battery_level() + "%"
                Utils.handle_battery_monitor(statusbar.battery_container, statusbar.battery_level)
            }
        }


    }




SlideLiner{
    id: slideLiner
width: root.width
visible: true
x: 0
y: root.height - slideLiner.height
MouseArea {
    anchors.fill: parent
    drag.target: application_container
    drag.axis: Drag.YAxis
    drag.maximumY: root.height
    onReleased: {
        if(-application_container.y > root.height / 3) {
           md=false
            slide.start()

        } else {

            bounce.start()

        }
    }
    onClicked: {
        md = true
     slide.start()


    }

}


}




BgBlur{
    id: bgBlur
    visible: false
    opacity: 0
}

LockScreen {
     id: lockscreen
     width: root.width
     height: root.height
     visible: true
     z: 4000
}
SettingSheet{
     id: settingSheet
     width: root.width
     height: root.height
   // x: - 200
     visible: true
    //z: 2000

 }
StatusBar {
    id: statusbar
    height: 20
    width: root.width
}

VolumeUi{
    id: volumeUi
   width: root.width - 32
   x: 16
   y: 50

    visible: false

}



}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
