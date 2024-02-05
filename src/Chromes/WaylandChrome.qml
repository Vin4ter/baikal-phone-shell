/*
import QtQuick 2.14
import QtWayland.Compositor 1.14

ShellSurfaceItem {
    anchors {
        top: parent.top
        left: parent.left
    }
    sizeFollowsSurface: false
    shellSurface: modelData
    onSurfaceDestroyed: shellSurfaces.remove(index)
    visible: true
    autoCreatePopupItems: true
}
*/

import QtQuick 2.14
import QtWayland.Compositor 1.14

ShellSurfaceItem {
    anchors {
        top: parent.top
        left: parent.left
    }
   //  anchors { top: parent.top; topMargin: 85; left: parent.left; }
   // anchors.fill: parent
     // moveItem: sidebar
    sizeFollowsSurface: true
    autoCreatePopupItems: true
    touchEventsEnabled: true
    shellSurface: modelData
    //maximizedRect : this
    onSurfaceDestroyed: shellSurfaces.remove(index)

    onSurfaceChanged: {

    }

    visible: true

}
