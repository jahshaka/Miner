import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import DataProvider 1.0

BasePage {

    id: logPage

    property DataProvider provider: null

    signal goback
    signal copy
    signal added

  //  padding: 10
  //  topPadding: 15

    onAdded: {
        bar.itemAt(0).textColor = "#fff"
    }

    Label{
        id: label
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 8
        text: qsTr("Logs")
        padding: 7
        bottomPadding: 11
        color: "#fff"
        font.pixelSize: Qt.application.font.pixelSize * 1.8
        font.weight: Literals.fontWeightLarger
    }


//    ColumnLayout {
//        spacing: 0
//        anchors{
//            left: parent.left
//            right: parent.right
//            bottom: parent.bottom
//            top: label.bottom
//            topMargin: -label.height
//        }
        TabBar {
            id: bar
            padding: 0
            anchors.right: parent.right
            anchors.rightMargin: 15
         //   anchors.top: parent.top
         //   anchors.topMargin: 10
            anchors.bottom: stack.top
            anchors.bottomMargin: 10

            implicitHeight: 25

            background: Rectangle{
                color: Literals.transparent
            }

            Component {
                id: tabbtn

                CustomTabBbutton{
                    id: btn
                    onAdditional: {
                        bar.getBtn(btn)
                    }
                }
            }

            function getBtn(btn){
                for (var i = 0; i < bar.children.length; i++){
                    bar.itemAt(i).textColor = "#777"
                }
                btn.textColor = "#fff"
            }

        }

        StackLayout {
            id: stack
         //   width: parent.width
            currentIndex: bar.currentIndex
            anchors.top: label.bottom
            anchors.topMargin: 2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom


        }

       // Item {
       //     //width: 15
       //     id:space
       //     anchors.top: stack.bottom
       //     anchors.bottom: parent.bottom
       //     implicitHeight: 5
       // }
    //}

    function addProvider(provider) {
        var comp
        var card

        //create cards and pass info
        comp = Qt.createComponent("LogItem.qml")

        if (comp.status == Component.Ready) {
            card = comp.createObject(stack, {
                                         provider: provider
                                     })
            var btn = tabbtn.createObject(bar, {
                                              textValue: "Miner " + provider.getIndex(), "index" : provider.getIndex()
                                          })

            logPage.added();
        } else {
            comp.statusChanged.connect(createProvider(provider, comp))
        }
    }

    function createProvider(provider, comp) {
        var card
        card = comp.createObject(stack, {
                                     provider: provider
                                 })
        var btn = tabbtn.createObject(bar, {
                                          textValue: "Miner " + provider.getIndex(), "index" : provider.getIndex()
                                      })
        logPage.added();

    }


}

