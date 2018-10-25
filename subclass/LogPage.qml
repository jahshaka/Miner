import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Pane {

    id: logPage
    signal goback()
    Behavior on opacity{
        NumberAnimation{
            duration: 300
        }
    }

    Behavior on scale{
        NumberAnimation{
            duration: 300
        }
    }

    anchors.fill: parent

    background: Rectangle{
        color: Literals.transparent
    }

    ColumnLayout{
        spacing: 1
        anchors.fill: parent

        RowLayout{
            spacing: 1
            Layout.fillWidth: true
            anchors.top: parent.top
            anchors.topMargin: -15

            Item{
                Layout.fillWidth: true
            }

            LogButton{
                id : buttonSave
                textValue: "save"
                onClicked: {
                    logPage.goback()
                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            anchors.top: parent.top
            anchors.topMargin: 10
            TextArea{
                id: textArea
                placeholderText: "press start to begiin logging"
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#99ffffff"
                background: Rectangle{
                    border.width: 1
                    border.color: "#99eeeeee"
                    color: "#00ffffff"
                }

            }
        }
    }


    function append(text){
        textArea.append(text)
    }

}
