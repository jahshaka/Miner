import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1

Pane {

    id: pane
    property alias labeld: label.text
    //    property alias textfieldd: textfield.placeholderText
    property alias textValue: textfield.text
    property string iconPath: ""
    property bool isPassword: false
    Layout.fillWidth: true
    height: 155
    property alias rowLayout: rowLayout
    background: Rectangle {
        radius: 3
        color: "#00ffffff"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Label {
            id: label
            leftPadding: 0
            bottomPadding: 5
            text: "walled id "
            font.pixelSize: Qt.application.font.pixelSize * 1.2
            font.weight: Literals.fontWeightLarger
            color: "#99ffffff"
            background: Rectangle {
                color: Literals.transparent
            }
        }
        RowLayout {
            spacing: 0
            Layout.fillWidth: true

            //            Rectangle{
            //                color: "#11ddddff"
            //                implicitWidth:  textfield.height+ 6
            //                implicitHeight:  textfield.height
            //                RowLayout{
            //                    anchors.fill: parent
            //                    Image {
            //                        id: name
            //                        Layout.margins :{
            //                            left: 6
            //                            top : 1
            //                        }

            //                        source: "../" + iconPath
            //                        sourceSize.height: textfield.height
            //                        sourceSize.width: textfield.height

            //                    }
            //                }
            //            }
            Rectangle {
                implicitWidth: 5
            }

            Rectangle {
                implicitHeight: 25
                Layout.fillWidth: true
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
                        echoMode: isPassword ? TextInput.Password : TextInput.Normal
                        selectByMouse: true
                    }
                }
            }
        }
    }
}
