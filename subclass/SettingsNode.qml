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


            Label {
                id: label
                leftPadding: 0
                bottomPadding: 5
                anchors.left: parent.left
                anchors.top: parent.top
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
                implicitWidth: shouldFillWidth? parent.width * .4 : 40
                anchors.left: label.right
                anchors.top: parent.top

            }

            Rectangle {
                implicitHeight: 25
                Layout.fillWidth: true
                Layout.minimumWidth: parent.width * .7
                anchors.right: parent.right
                anchors.left: space.right
                anchors.top: parent.top
                anchors.topMargin: -6
                color: "#0addddff"
                radius: 2
                clip: true



                    TextInput {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.topMargin: 5
                        autoScroll: false
                        anchors.centerIn: parent
                        id: textfield
                        y: 0
                        height: 50
                        font.pixelSize: Qt.application.font.pixelSize * 1.3
                        color: "#eeffffff"
                        selectionColor: "#468aab"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        selectByMouse: true
                    }
                }





}
