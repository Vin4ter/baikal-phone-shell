/*
add in ~/.config/gtk-3.0/gtk.css

decoration {
    border-width: 0px;
    box-shadow: none;
    margin: 0px;
}

I HATE GTK 3 DROP SHADOW BTW

*/

import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.LocalStorage 2.14
import QtQuick.Layouts 1.14
import QtWayland.Compositor 1.15
 import "utils/settings.js" as Settings
import "utils/utils.js" as Utils
import "UI"

Item {
    property alias root: screen_loader.item
   property alias window: wayland_window.screen
    property real shellScaleFactor: 1
   property int volume: 50


    Connections {
           target:  globalParams

         onSet_qml_scale: {
            shellScaleFactor = scale;
           }
       }
    Component.onCompleted: {
        globalParams.getScale()
    }

    function volUp(){
          root.volume_ui.showOp();
          if(volume<100 ){
        volume+=10
    console.log("volup")


    root.volume_ui.setValue(volume)
    }
    }
    function volDown(){
        root.volume_ui.showOp();
        if(0<volume){
      volume-=10
  console.log("voldown")


  root.volume_ui.setValue(volume)
  }

    }
    function lock(){
    console.log("lock")
              root.volume_ui.visible = true;
    }

    WaylandCompositor {
        id: wayland_compositor
        useHardwareIntegrationExtension:true

        WaylandOutput {
            window: Window {
               // visibility: "FullScreen"
                Item {
                    id: state_handler
                    state: (Settings.get("setup_done") === "true") ? "locked" : "setup"
                    states: [
                        State {
                            name: "locked"
                        },
                        State {
                            name: "normal"
                        },
                        State {
                            name: "multitasking"
                        },
                        State {
                            name: "setup"
                        },
                        State {
                            name: "settingSheet"
                        }
                    ]
                }

                Component.onCompleted: {
                    Settings.getDatabase()
                    //xwayland.startServer()
                }
                visible: true
                title: qsTr("Baikal - Phone Screen")
                //base screen resolution for the setup.
                width: (Settings.get("setup_done") === "true") ? Settings.get("screen_width") : 480
                height: (Settings.get("setup_done") === "true") ? Settings.get("screen_height") : 800
                id: wayland_window

                Rectangle{
                   id: bgStatusBar
                   width: root.width
                   height: statusbar.height
                   y:0
                   x:0
                   color: "#373737"

                }
                Loader {
                    id: screen_loader
                    source: (state_handler.state != "setup") ? "UI/Screen.qml" : "UI/Setup.qml"
                }
            }
        }
        XdgShell {
            onToplevelCreated: {
              shellSurfaces.append({
                    shellSurface: xdgSurface
             })
                // handleShellSurface(xdgSurface)
                toplevel.sendResizing(Qt.size(wayland_window.width*shellScaleFactor, (wayland_window.height - root.statusbar.height - root.slideLiner.height)*shellScaleFactor ))

            }
        }


        XdgDecorationManagerV1 {
            preferredMode: XdgToplevel.ServerSideDecoration
        }

        ListModel {
            id: shellSurfaces
        }
        WlShell {
            onWlShellSurfaceCreated: {
            wayland_compositor.handleShellSurface(shellSurface)

            }
        }

    }
}





