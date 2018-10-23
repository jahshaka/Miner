import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Pane {
    property string linkText: "value"
    property string labelText: "value"
    property string explanation: "value"
    Layout.fillWidth: true

    background: Rectangle{
        color: Literals.transparent
        border.width: Literals.borderWidth
        border.color: Literals.borderColor
    }

    ColumnLayout{
        anchors.fill: parent

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
                id: textExplanation
                text: qsTr(explanation)
                color: "#ddffffff"
                font.pixelSize: Qt.application.font.pixelSize * 1.2
                font.weight: Literals.fontWeight

            }

        }

        RowLayout{
            anchors.left: parent.left
            anchors.right: parent.right
            Item {
                id: space
                Layout.fillWidth: true
            }
            LogButton{
                textValue: linkText
            }

        }


    }

}
