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
            Layout.fillWidth: true

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
                RowLayout{
                    spacing: 1
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5



                    LogButton{
                        id : buttonSave
                        textValue: tr("<- graph")
                        onClicked: {
                            logPage.goback()
                        }
                    }
                }
            }
        }
    }


}
