import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Rectangle {
    id: settingSheet
    width: 480
    height: 800
    color: "transparent" //"#cc000000"
   // color: "#393939"
    y: -root.height //+ statusbar.height
    // color: "red"



    GridView{
        id: settingsGreed
        y: 99
        width: 400
        height: 159 * (settingsGreed.width/2/208)
        anchors.left: parent.left
        anchors.right: parent.right
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        cellHeight: (settingsGreed.height) / 2
        clip: true
        cellWidth: (settingsGreed.width) / 2
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        model: settingsModel
   delegate:

       Rectangle {
           id: qsDelegate
           width: 208 * ((settingsGreed.width-10)/2/208)


           height: 65 * ((settingsGreed.width-10)/2/208)
           color: "#66ffffff"
           radius: 18 * (settingsGreed.width/2/208)
           property bool active: m_active
             property string func: m_func
           x: 17
           y: -110
           MouseArea{
               anchors.fill: parent
          onClicked: {
              if(active == true){
                       rectbg.color = "#b4c2e0"
                              active = false
                  if(func=="wlan"){
                    nm.toggleWifi()
                  }
              }else{
                      rectbg.color = "#5171ba"
                  active = true
                  if(func=="wlan"){
                     nm.toggleWifi()
                  }
              }


          }
         }
           Rectangle {
               id: rectbg
               color:
                   if(active==false){
                       return "#b4c2e0"
                   }else{
                       return "#5171ba"
                   }


               radius: 255
             //  anchors.left: parent.left
             //  anchors.right: parent.right
               anchors.top: parent.top
               anchors.bottom: parent.bottom
             //  anchors.rightMargin: 150
               anchors.leftMargin: 8
               anchors.bottomMargin: 7
               anchors.topMargin: 4
               width: rectbg.height


               Image {
                   id: image
                   anchors.fill: parent

                   anchors.leftMargin: 2
                      anchors.rightMargin:2
                   anchors.topMargin:2
                       anchors.bottomMargin:2


                   source: m_image
                        sourceSize.width:  image.width
                    sourceSize.height: image.height
                   fillMode: Image.PreserveAspectFit
               }
           }

           Text {
               id: text2
               y: 24
               height: 18
               color: "#ffffff"
               text: m_name
               anchors.left: rectbg.right
               anchors.right: parent.right
               font.pixelSize: 13
               anchors.leftMargin: 6
               anchors.rightMargin: 0
           }
           }




}
















ListModel{
 id: settingsModel
 ListElement{
 m_name: "Сеть"
 m_image: "qrc:/icons/wireless-symbolic.svg"
 m_active: true
 m_func: "wlan"
 }
 ListElement{
 m_name: "Мобильные данные"
  m_image: "qrc:/icons/cellNetwork.svg"
 m_active: false
 }
 ListElement{
 m_name: "Bluetooth"
 m_image: "qrc:/icons/bluetooth-active-symbolic.svg"
  m_active: false
 }
 ListElement{
 m_name: "Звук"
 m_image: "qrc:/icons/audio-volume-high-symbolic.svg"
  m_active: false
 }
 ListElement{
 m_name: "Режим самолета"
 m_image: "qrc:/icons/airplanemode-on.svg"
  m_active: false
 }
 ListElement{
 m_name: "Точка доступа"
 m_image: "qrc:/icons/network-hotspot.svg"
  m_active: false
 }
 ListElement{
 m_name: "Выключить"
  m_image: "qrc:/icons/system-shutdown.svg"
   m_active: false
 }

}



    Text {
        id: text3
        width: 289
        height: 30
        color: "#ffffff"
        text: qsTr("Панель управления")
        anchors.left: parent.left
        anchors.top: parent.top
        font.pixelSize: 24
        anchors.leftMargin: 17
        anchors.topMargin: 57
        minimumPixelSize: 12
    }



    MouseArea {
        y: 800
        height: 100
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        drag.target: settingSheet; drag.axis: Drag.YAxis; drag.minimumY: -root.height+statusbar.height; drag.maximumY: 0
        //onPressAndHold: {
        //    screenshotTimer.start();
        // slide.start
        //}
        //onClicked: {
        //    if (settingSheet.y > -535) {             state_handler.state  = "normal" } else { state_handler.state = "settingSheet" }
        // }
        onReleased: {
            if(settingSheet.y<-25){
            bgBlur.hideOp()
                state_handler.state = "normal"
                           settingSheet.downUp()
                  //      bgBlur.visible = false
            }else{
                cslide.start()
                state_handler.state = "settingSheet"

              //   bgBlur.visible = true
               // bgBlur.showOp()
                      //
            }

            //   if (settingSheet.y > -535) {  state_handler.state = "settingSheet" } else {    state_handler.state  = "normal"}
        }
        onPressed: {
            statusbar.opacity = 0
        }
    }
    function showUp(){
        cslide.start()
    }
    function downUp(){
        bounce.start()
    }
    Rectangle{
        id: brightnessBar
        height: 30
        color: "transparent"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: settingsGreed.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 17

        Rectangle{
            id: volumeBarTrack
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                left: parent.left
                rightMargin: 0
                leftMargin: 0
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
            }

            onXChanged: {
                var fullrange = volumeBarTrack.width - volumeBarThumb.width
                var val = 100*(volumeBarThumb.x - volumeBarTrack.x)/fullrange
                displayBrightness.setBrightness(val);
            }
        }
    }

    //  PropertyChanges { id: slide; target: settingSheet; y: 0 }
    Text {
        id: text1
        x: 96
        width: 289
        height: 116
        color: "#9d9d9d"
        text: qsTr("нет событий")
        anchors.top: parent.top
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.topMargin: 499
        minimumPixelSize: 7
    }


    NumberAnimation {
        id: cslide
        target: settingSheet
        properties: "y"
        to: 0
        easing.type: Easing.InOutQuad
        duration: 325
        onStopped: {

            statusbar.opacity = 1

        }
    }
    NumberAnimation {
        id: bounce
        target: settingSheet
        properties: "y"
        to: -root.height// + statusbar.height
        easing.type: Easing.InOutQuad
        duration: 325
        onStopped: {

            statusbar.opacity = 1

        }
    }







}








