import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
Rectangle {
    id: btn

    property real textSize: 0
     property string textValue: ""
     signal clicked();

     implicitHeight: text1.height +10
     implicitWidth: text1.width +16

     color: Literals.transparent
     border.width: 1
     border.color: "#88ffffff"

     Behavior on color {
         ColorAnimation{
             duration: 400
         }
     }


        Text {
            id:text1
            anchors.centerIn: parent
            text: textValue
            font.weight: Literals.fontWeight
            color: Literals.fontcolor
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            font.pixelSize: textSize==0 ? Qt.application.font.pixelSize * 1.1 : Qt.application.font.pixelSize * textSize
        }


    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            btn.color = "#99444444"
            cursorShape = Qt.PointingHandCursor
        }

        onExited: {
            btn.color =  Literals.transparent
            cursorShape = Qt.ArrowCursor

        }

       onPressed: {
          btn.color =  "#99888888"
         }
       onReleased: {
             btn.color =  Literals.transparent
       }
        onClicked: {
            btn.clicked()
        }
    }

}
