import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Pane {
    id:pane
    property string linkText: "value"
    property string labelText: "value"
    property string explanation: "value"
    signal clicked()
    Layout.fillWidth: true
    //implicitWidth: 120
    implicitHeight: 90


      //  topPadding: 12
       // leftPadding : 28
      //  rightPadding :28
      //  bottomPadding : 12


    background: Rectangle{
        id : bg
        color: Literals.transparent
        border.width: Literals.borderWidth
        border.color: Literals.borderColor

    }


    RowLayout{
        anchors.fill: parent

        Rectangle{
            id: btnLink
            implicitHeight: parent.height
            implicitWidth: parent.height
            color: Literals.transparent
            radius: 2
            border.color: Literals.borderColor
            border.width: Literals.borderWidth

            Behavior on color {
                ColorAnimation{
                    duration: 200
                }
            }
            RowLayout{
               anchors.fill: parent
               Label {
                   id: lab
                   Layout.fillWidth: true
                   Layout.fillHeight: true
                   text : labelText
                   font.pixelSize: Qt.application.font.pixelSize * 1
                   font.weight: Literals.fontWeightLarger
                   color: "#eeffffff"
                   wrapMode: Text.WordWrap
                   verticalAlignment: Text.AlignVCenter
                   horizontalAlignment: Text.AlignHCenter

                   Behavior on color {
                       ColorAnimation{
                           duration: 200
                       }
                   }
               }



           }

            MouseArea{
                id: area
                anchors.fill: btnLink
                hoverEnabled: true
                onClicked: {
                    pane.clicked()
                }
                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                    btnLink.color = "#99444444"
                    btnLink.color =  Literals.blueButtonColor
                 //   lab.color = Literals.blueButtonColor
                }

                onExited: {
                    cursorShape = Qt.ArrowCursor
                    btnLink.color = Literals.transparent

                  //  lab.color = "#eeffffff"

                }

                onPressed: {
                    btnLink.color =  "#99888888"
                    btnLink.color = Literals.blueButtonColorHovered
                  //  lab.color = "#aaffffff"
                  }
                onReleased: {
                    btnLink.color =  Literals.transparent

                   // lab.color = "#eeffffff"
                }
            }

        }

   ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
//       RowLayout{
//          anchors.left: parent.left
//          anchors.right: parent.right
//          Label {
//              text : labelText
//              font.pixelSize: Qt.application.font.pixelSize * 1.6
//              font.weight: Literals.fontWeightLarger
//              color: "#eeffffff"
//          }



//      }
       RowLayout{
           anchors.left: parent.left
           anchors.right: parent.right
           Text {
               leftPadding: 12
               Layout.fillWidth: true
               id: textExplanation
               text: qsTr(explanation)
               color: "#ddffffff"
               font.pixelSize: Qt.application.font.pixelSize * 1.6
               font.weight: Literals.fontWeight
               wrapMode: Text.Wrap
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter

           }

       }


   }

        Item {
            id: name
            Layout.fillHeight: true
        }

//        RowLayout{
//            anchors.left: parent.left
//            anchors.right: parent.right
//            Item {
//                id: space
//                Layout.fillWidth: true
//            }
//            LogButton{
//                textValue: linkText
//                textSize: 1.1
//            }

//        }


    }

}
