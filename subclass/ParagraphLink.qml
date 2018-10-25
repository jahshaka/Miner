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
    Layout.fillHeight: true


        topPadding: 22
        leftPadding : 28
        rightPadding :28
        bottomPadding : 22


    background: Rectangle{
        id : bg
        color: Literals.transparent
        border.width: Literals.borderWidth
        border.color: Literals.borderColor
        Behavior on color {
            ColorAnimation{
                duration: 200
            }
        }
    }






    ColumnLayout{
        anchors.fill: parent
        MouseArea{
            id: area
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                pane.clicked()
            }
            onEntered: {
                cursorShape = Qt.PointingHandCursor
                bg.color = "#99444444"
            }

            onExited: {
                cursorShape = Qt.ArrowCursor
                bg.color = Literals.transparent
            }

            onPressed: {
               bg.color =  "#99888888"
              }
            onReleased: {
               bg.color =  Literals.transparent
            }
        }


        RowLayout{
           anchors.left: parent.left
           anchors.right: parent.right
           Label {
               text : labelText
               font.pixelSize: Qt.application.font.pixelSize * 1.6
               font.weight: Literals.fontWeightLarger
               color: "#eeffffff"
           }



       }
        RowLayout{
            anchors.left: parent.left
            anchors.right: parent.right
            Text {
                Layout.fillWidth: true
                id: textExplanation
                text: qsTr(explanation)
                color: "#ddffffff"
                font.pixelSize: Qt.application.font.pixelSize * 1.2
                font.weight: Literals.fontWeight
                wrapMode: Text.Wrap

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
