import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import DataProvider 1.0

Pane {

    property DataProvider provider: null
    padding: 0
    leftPadding: 15
    rightPadding: 15
    bottomPadding: 8

   //  anchors.topMargin: -55

    Connections {
        target: provider

        onMinerOutput: {
            textArea.append(text)
        }
    }


   // Layout.fillWidth: true
   // Layout.fillHeight: true
    background: Rectangle{
        color: Literals.transparent
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 5


        RowLayout {
            Layout.fillWidth: true
            spacing: 0

            ScrollView{
                Layout.fillWidth: true
                Layout.fillHeight: true
                padding: 0

                TextArea {
                    id: textArea

                    Layout.fillWidth: true
                    placeholderText: "If there are errors in the mining process they will show up here for Miner " + provider.getIndex() +"..."

                    color: "#99ffffff"
                    readOnly: true
                    selectByMouse: true
                    background: Rectangle {
                        border.width: 1
                        border.color: "#39eeeeee"
                        color: "#000"
                    }
                }
            }
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: 0
            Item {
                id: space1
                Layout.fillWidth: true
            }
            LogButton {
                id: buttonSave
                textValue: "copy to clipboard"
                opacity: 0.65
                onClicked: {
                    provider.saveMinerOutput()
                }
            }
        }
    }
}