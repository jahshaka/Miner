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
    property string col : Literals.blueButtonColor

    signal clicked()

    MouseArea{
        anchors.fill: parent
    hoverEnabled: true

        onEntered: {
            btn.color = Qt.darker(col, 1.4)
        }

        onExited: {
            btn.color = col
        }

     onPressed: {
         btn.color = Qt.darker(col, 1.7)
     }
     onReleased: {
         btn.color = col
     }
        onClicked: {
            btn.clicked()
        }
    }



        color: col

        implicitWidth: 90
        implicitHeight:  width/3
        border.width: 0
        border.color: "#880099ee"
        radius: .5

        Behavior on color {
            ColorAnimation {
                duration: 200
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
            font.pixelSize: Qt.application.font.pixelSize * 1.6

        }
    }

    DropShadow {
            horizontalOffset:0
            verticalOffset: 0
            radius: 1.0
            samples: 17
            color: "#80ffffff"
            source: btn
        }

//    ColorOverlay{
//        color: "#55ffffff"
//        source: btn
//        implicitHeight: 1
//        implicitWidth: parent.width
//        anchors.top: parent.top
//    }
//    ColorOverlay{
//        color: "#55000000"
//        source: btn
//        implicitHeight: 1
//        implicitWidth: parent.width
//        anchors.bottom: parent.bottom
//    }
}
