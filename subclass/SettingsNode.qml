import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1

Pane {

    id: pane
    property alias labeld: label.text
    //    property alias textfieldd: textfield.placeholderText
    property alias textValue: textfield.text
    property string iconPath: ""
    property bool shouldFillWidth: true

    Layout.fillWidth: true
    height: 155

    background: Rectangle {
        radius: 3
        color: "#00ffffff"
    }


        RowLayout {
            spacing: 0
            anchors.fill: parent

            Rectangle {
                implicitWidth: 5
            }

            Label {
                id: label
              //  Layout.fillWidth: shouldFillWidth
                leftPadding: 0
                bottomPadding: 5
                text: "wallet id "
                font.pixelSize: Qt.application.font.pixelSize * 1.2
                font.weight: Literals.fontWeightLarger
                color: "#99ffffff"
                background: Rectangle {
                    color: Literals.transparent
                }
            }

            Rectangle{
                id: space
                implicitWidth: shouldFillWidth? parent.width * .4 : 30
            }

            Rectangle {
                implicitHeight: 25
                Layout.fillWidth: true
                Layout.minimumWidth: parent.width * .7
                anchors.right: parent.right
                anchors.left: space.right
                color: "#0addddff"
                radius: 2
                clip: true

                RowLayout {
                    id: rowLayout
                    anchors.fill: parent

                    TextInput {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.topMargin: 5
                        autoScroll: false
                        id: textfield
                        y: 0
                        height: 50
                        font.pixelSize: Qt.application.font.pixelSize * 1.1
                        color: "#eeffffff"
                        selectionColor: "#468aab"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        selectByMouse: true
                    }
                }
            }
        }



}
