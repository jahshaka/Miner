import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Rectangle {
    id: btn
    property string imageSource: ""
    property string textValue: ""

    signal clicked()


    MouseArea{
        anchors.fill: parent
    hoverEnabled: true

        onEntered: {
            btn.color = Literals.blueButtonColorHovered
        }

        onExited: {
            btn.color = Literals.blueButtonColor
        }

     onPressed: {
         btn.color = Literals.blueButtonColorPressed
     }
     onReleased: {
         btn.color = Literals.blueButtonColor
     }
        onClicked: {
            btn.clicked()
        }
    }

        color: Literals.blueButtonColor
        implicitWidth: 120
        // implicitHeight:  parent.height
        Behavior on color {

            ColorAnimation {
                duration: 100
            }
        }

    Layout.fillHeight: true
    Layout.fillWidth: false
    RowLayout {
        anchors.fill: parent
        Image {
            id: name
            source: imageSource == "" ? "" : "../" + imageSource
            sourceSize.width: imageSource == "" ? 0 : 20
        }
        Text {
            text: textValue
            font.weight: Literals.fontWeight
            color: Literals.fontcolor
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }
    }
}
