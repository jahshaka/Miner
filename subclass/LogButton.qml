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

     implicitHeight: 20
     implicitWidth: 50
     color: Literals.transparent
     border.width: 1
     border.color: "#88ffffff"

     Behavior on color {
         ColorAnimation{
             duration: 400
         }
     }

    RowLayout{
        anchors.fill: parent


        Text {
            id:text1
            text: textValue
            font.weight: Literals.fontWeight
            color: Literals.fontcolor
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            font.pixelSize: textSize==0 ? Qt.application.font.pixelSize * .8 : Qt.application.font.pixelSize * textSize
        }

    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            btn.color = "#99444444"
        }

        onExited: {
            btn.color =  Literals.transparent
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
