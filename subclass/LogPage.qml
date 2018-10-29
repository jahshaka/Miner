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

    ColumnLayout{
        spacing: 5
        anchors.fill: parent

        TabBar {
            id: bar
            width: parent.width
            Component{
                id: tabbtn
                LogButton{

                    }
                }
            }


        StackLayout {
            id:stack
            width: parent.width
            currentIndex: bar.currentIndex

        }
}
    function addProvider(provider){
        var comp;
        var card;

        //create cards and pass info
        comp = Qt.createComponent("LogItem.qml")

        if (comp.status == Component.Ready){
            card = comp.createObject(stack,{"provider" : provider })
            var btn = tabbtn.createObject(bar, {"textValue": "Miner "+provider.getIndex() })
        }
        else{
            comp.statusChanged.connect(  createProvider(provider, comp));
        }

    }

    function createProvider(provider, comp){
        var card
        card = comp.createObject(stack,{"provider" : provider })

    }


}
