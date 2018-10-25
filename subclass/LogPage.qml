import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Pane {

    id: logPage
    signal goback()
    signal copy()

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
                textValue: "copy to clipboard"
                onClicked: {
                    logPage.copy()
                }
            }

        }
        RowLayout{
            Layout.fillWidth: true
            anchors.top: parent.top
            anchors.topMargin: 10
            TextArea{
                id: textArea
                placeholderText: "If there are errors in the mining process they will show up here..."
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#99ffffff"
                readOnly : true
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
