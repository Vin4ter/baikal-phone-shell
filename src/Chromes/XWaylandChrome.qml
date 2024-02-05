import QtQuick 2.14
import Liri.XWayland 1.0 as LXW

LXW.XWaylandShellSurfaceItem {
    anchors {
        top: parent.top
        left: parent.left
    }
    sizeFollowsSurface: false
    shellSurface: modelData
    onSurfaceDestroyed: shellSurfaces.remove(index)
    visible: true
}
