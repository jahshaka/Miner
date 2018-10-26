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
    property string bgcolor: Literals.transparent
    signal clicked


    Behavior on bgcolor {

        ColorAnimation {
            duration: 200
        }
    }
    Layout.fillHeight: true
    implicitWidth: 115
    color: Literals.transparent
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            bgcolor = Literals.buttonColorHovered
        }

        onExited: {
            bgcolor = Literals.transparent
        }

        onPressed: {
            bgcolor = Literals.buttonColorPressed
        }
        onReleased: {
            bgcolor = Literals.transparent
        }
        onClicked: {
            btn.clicked()
        }
    }


    Rectangle {
        id: leftrect
        border.color: Literals.borderColor
        color: Literals.borderColor
        implicitWidth: .5
        implicitHeight: parent.height
        opacity: .2
        anchors.left: parent.left
    }

    Rectangle {
        anchors.fill: parent
        color: bgcolor
//        anchors.margins: {
//            left: 0
//            right: 0
//            top: 2
//            bottom: 2
//        }





        RowLayout {
            anchors.fill: parent
            spacing: 5


            HorizontalSpacer {
            }

            Image {
                id: buttonimage
                source: "../" + imageSource
                sourceSize.width: 20
                verticalAlignment: Image.AlignBottom
            }
            Label {
                id: textval
                text: textValue
                color: Literals.fontcolor
                font.weight: Literals.fontWeight
                font.pixelSize: Qt.application.font.pixelSize * 1.4
                height: buttonimage.height
                baselineOffset: 0
                Layout.topMargin: 2
                verticalAlignment: Label.AlignBottom
            }
            HorizontalSpacer {
            }
        }
    }
}
