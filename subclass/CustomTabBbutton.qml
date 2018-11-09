import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


TabButton {
    id: tabBtn
    property int index: 0
    property string textValue : ""
    property bool check : false
    property string textColor: "#777"
    signal additional()
    implicitWidth: text.width + 20
    implicitHeight: text.height + 16

    checkable: false

    Text {
        anchors.centerIn: parent
        id: text
        text: qsTr(textValue)
        color: textColor
        Behavior on color {
            ColorAnimation {
                duration: 400
            }
        }
    }



  background: Rectangle {
        id: btn
        color: Literals.transparent
        border.width: 1
        border.color: "#888"
        Behavior on color {
            ColorAnimation {
                duration: 400
            }
        }
        Behavior on border.color {
            ColorAnimation {
                duration: 400
            }
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
           bar.currentIndex = index - 1

           tabBtn.additional()
       }

    }
}
