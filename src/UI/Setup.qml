 import QtQuick 2.14
import QtQuick.LocalStorage 2.14
import QtQuick.Controls 2.14
import "../utils/settings.js" as Settings

Rectangle {
    id: root
    color: "black"
    width: wayland_window.width
    height: wayland_window.height

    Text {
        text: "Hello."
        color: "#ffffff"
        wrapMode: Text.WordWrap
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: parent.height / 30
        anchors {
           horizontalCenter: parent.horizontalCenter
           verticalCenter: parent.verticalCenter
        }
    }
    Button {
        text: "Start"
        background: Rectangle {
            color: "grey"
            radius: 4
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: parent.height / 100
        }

        onClicked: {
            Settings.set("setup_done", "true")
            Settings.set("screen_width", 480)
            Settings.set("screen_height", 800)
            Settings.set("applications_per_row", 4)
            Settings.set("statusbar_screen_offset", 5)
            Settings.set("wallpaper_path", offlineStoragePath + "Resources/Wallpapers/wallpaper_1.jpg")
            Settings.set("default_colour", "#8f8bd8")
            Settings.set("scaling_factor", 1)
            state_handler.state = "locked"

        }
    }

}
