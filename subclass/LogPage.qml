import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import DataProvider 1.0

BasePage {

    id: logPage

    property DataProvider provider: null

    signal goback()
    signal copy()


    Connections{
        target: provider

        onMinerOutput:{
            logPage.append(text)
        }
    }

    padding: 15

    background: Rectangle{
        color: Literals.transparent
    }

    ColumnLayout{
        spacing: 5
        anchors.fill: parent

//        RowLayout{
//            spacing: 1
//            Layout.fillWidth: true
////            anchors.top: parent.top
////            anchors.topMargin: -15

//            Item{
//                Layout.fillWidth: true
//            }

//            LogButton{
//                id : buttonSave
//                textValue: "copy to clipboard"
//                opacity: 0.65
//                onClicked: {

//                        provider.saveMinerOutput()

//                }
//            }

//        }
        RowLayout{
            Layout.fillWidth: true
         //   anchors.top: parent.top
         //   anchors.topMargin: 10

            ScrollView{
                id : scroll
                anchors.fill: parent
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout{
                    id : col
                    width: scroll.width

                }

//            TextArea{
//                id: textArea
//                placeholderText: "If there are errors in the mining process they will show up here..."

//                color: "#99ffffff"
//                readOnly : true
//                selectByMouse: true
//                background: Rectangle{
//                    border.width: 1
//                    border.color: "#39eeeeee"
//                    color: "#00ffffff"
//                }

//            }
            }
        }
    }


    function append(text){
        textArea.append(text)
    }

    function addProvider(provider){
        var comp;
        var card;

        //create cards and pass info
        comp = Qt.createComponent("LogItem.qml")

        if (comp.status == Component.Ready){
            card = comp.createObject(col,{"provider" : provider })
        }
        else{
            comp.statusChanged.connect(  createProvider(provider, comp));
        }

    }

    function createProvider(provider, comp){
        var card
        card = comp.createObject(col,{"provider" : provider })

    }


}
