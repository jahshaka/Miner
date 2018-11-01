import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import DataProvider 1.0

Pane {

    property DataProvider provider: null
    onProviderChanged: {
        console.log(provider + " changed")
    }


    Connections {
        target: provider

        onMinerOutput: {
            textArea.append(text)
        }
    }

    Layout.fillWidth: true
    Layout.fillHeight: true
    background: Rectangle{
        color: Literals.transparent
    }

    ColumnLayout {
        anchors.fill: parent



        RowLayout {
            Layout.fillWidth: true
            ScrollView{
                Layout.fillWidth: true
                Layout.fillHeight: true
                //implicitHeight: 120


                TextArea {
                    id: textArea
                    Layout.fillWidth: true
                    //implicitHeight: 100
                    placeholderText: "If there are errors in the mining process they will show up here for Miner " + provider.getIndex() +"..."

                    color: "#99ffffff"
                    readOnly: true
                    selectByMouse: true
                    background: Rectangle {
                        border.width: 1
                        border.color: "#39eeeeee"
                        color: "#00ffffff"
                    }
                }
            }
        }
        RowLayout {
            Layout.fillWidth: true

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
