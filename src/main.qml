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
   property bool statusLock: false

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
       if(state_handler=="locked"){
           displayBrightness.setBrightness(100);
           //statusLock=false
           state_handler="normal"
       }else{
           state_handler="locked"
           displayBrightness.setBrightness(0);
           statusLock=true
       }
    }

    WaylandCompositor {
        id: wayland_compositor
        useHardwareIntegrationExtension:true

        WaylandOutput {
            window: Window {
               // visibility: "FullScreen"
                Item {
                    id: state_handler
                    state: "locked"
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
                width: 480
                height: 800
                id: wayland_window


                Loader {
                    id: screen_loader
                    source: "UI/Screen.qml"
                }
                Rectangle{
                    id: bgStatusBar
                    width: root.width
                    height: root.statusBar.height
                    x:0
                    y:0
                }
            }
        }
        XdgShell {
              onToplevelCreated: {
                shellSurfaces.append({shellSurface: xdgSurface});
                  toplevel.sendResizing(Qt.size(wayland_window.width*shellScaleFactor, (wayland_window.height - root.statusbar.height - root.slideLiner.height)*shellScaleFactor ))

              }

          }

          XdgDecorationManagerV1 {
              preferredMode: XdgToplevel.ServerSideDecoration
          }

          WlShell {
              onWlShellSurfaceCreated: {
                shellSurfaces.append({shellSurface: shellSurface});
              }
          }

        ListModel {
            id: shellSurfaces
        }



    }

}





