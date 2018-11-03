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

    topPadding: 15

    ColumnLayout {
        spacing: 0
        anchors.fill: parent



        TabBar {
            id: bar
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.bottom: swipe.top
            anchors.bottomMargin: -5

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
            width: parent.width
            currentIndex: bar.currentIndex
            anchors.top: bar.bottom

        }

        Item {
            //width: 15
            implicitHeight: 45
        }
    }

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
    }


}

