import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
FastBlur {
    id: bgBlur
    anchors.fill: parent
    source: bg

    radius: 76
    Rectangle {
    id: rectangle5
    color: "#66000000"
    radius: 0
    anchors.fill: parent
    }

    NumberAnimation {
      id: chide
           target: bgBlur

           properties: "opacity"

           from: 1.0

           to: 0

           duration: 200
           onStopped: {
               bgBlur.visible=false
           }


       }

    NumberAnimation {
      id: cshow
      target: bgBlur

      properties: "opacity"

      from: 0

      to: 1.0

      duration: 200


    }



    function hideOp(){
        chide.start()
    }
    function showOp(){
        cshow.start()
    }
}
