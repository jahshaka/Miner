import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import DataProvider 1.0

BasePage {

    id: logPage

    property DataProvider provider: null

    signal goback
    signal copy

    Connections {
        target: provider

        onMinerOutput: {
            logPage.append(text)
        }
    }

    padding: 15

    ColumnLayout {
        spacing: 5
        anchors.fill: parent

        TabBar {
            id: bar
            width: parent.width
            anchors.leftMargin: 10

            background: Rectangle{
                color: Literals.transparent
            }

            Component {
                id: tabbtn



                TabButton {
                    property int index: 0
                  background: Rectangle {
                        id: btn
                        color: Literals.transparent
                        border.width: 1
                        border.color: "#88ffffff"
                        Behavior on color {
                            ColorAnimation {
                                duration: 400
                            }
                        }
                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            btn.color = "#99444444"
                        }

                        onExited: {
                            btn.color =  Literals.transparent
                        }

                       onPressed: {
                          btn.color =  "#99888888"
                         }
                       onReleased: {
                             btn.color =  Literals.transparent
                       }
                       onClicked: {
                           bar.currentIndex = index - 1
                       }

                    }
                }
            }
        }

        StackLayout {
            id: stack
            width: parent.width
            currentIndex: bar.currentIndex

        }

        Item {
            //width: 15
            implicitHeight: 25
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
                                              text: "Miner " + provider.getIndex(), "index" : provider.getIndex()
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
    }
}
