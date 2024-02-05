import QtQuick 2.0
import QtQuick.Controls 2.12
Rectangle{
    id: volumeUi
width: 400
height: 60
color: "#373737"
radius: 27
border.width: 0



function setValue(val){
 console.log(val)
    var fullrange = volumeBarTrack.width - volumeBarThumb.width

     volumeBarThumb.x = ((fullrange * (val))/100) + volumeBarTrack.x
}

Rectangle{
    id: volumeBar
    y: 15
    height: 30
    color: "transparent"
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.rightMargin: 8
    anchors.leftMargin: 0

    Image {
        id: volumeHigh
        source: "../icons/audio-volume-high-symbolic.svg"
        width: 30; height: width; sourceSize.width: width*2; sourceSize.height: height*2;
        anchors{
            right: parent.right
            rightMargin: 20
            verticalCenter: parent.verticalCenter
        }
    }

    Rectangle{
        id: volumeBarTrack
        anchors{
            verticalCenter: parent.verticalCenter
            right: volumeHigh.left
            left: parent.left
            rightMargin: 20
            leftMargin: 27
        }
        height: 2
        radius: 1
        color: "#ECEFF4"
    }

    Rectangle{
        id: volumeBarThumb
        height: 30
        width: 30
        radius: 15
        y: volumeBarTrack.y - height/2
        x: volumeBarTrack.x + volumeBarTrack.width/2

        MouseArea{
            anchors.fill: parent
            drag.target: volumeBarThumb; drag.axis: Drag.XAxis; drag.minimumX: volumeBarTrack.x; drag.maximumX: volumeBarTrack.x - width + volumeBarTrack.width
        onPressed: {
      hideTimer.stop()
        }
        onReleased: {
                  hideTimer.start()
        }
        }

        onXChanged: {
            var fullrange = volumeBarTrack.width - volumeBarThumb.width
            var val = 100*(volumeBarThumb.x - volumeBarTrack.x)/fullrange
            alsaController.setVolume(val)


         //displayBrightness.setBrightness(val);
        }
    }
}

Timer{
    id: hideTimer
    running: false
    interval: 5000
    repeat: false
    onTriggered: {
        volumeUi.visible = false
     //   getAPTimer.running = false;
    }
}


function hideOp(){

}
function showOp(){
    volumeUi.visible = true
 hideTimer.start()
}


}
