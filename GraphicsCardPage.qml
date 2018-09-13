import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "subclass"
import MinerManager 1.0
import DataProvider 1.0

BasePage {


    property string walletid: manager.getWalletId();
    property string poolurl: manager.getPoolUrl();
    property string password: manager.getPassword();
    property string identifier: manager.getIdentifier();
    DataProvider{
        id: pro

        Component.onCompleted: {
            addGraphicsCard(pro)
        }
    }



 



    padding: 10
    background: Rectangle {
        color: Literals.darkBackgroundColor
    }



        ScrollView {
            id: scrollview
            width: parent.width
            height: parent.height
            Layout.fillWidth: true
            Layout.fillHeight: true

            clip: true
            padding: 10

            background: Rectangle {
                color: Literals.darkBackgroundColor
            }


            ColumnLayout {

                id: col
                spacing:5
                width: scrollview.width- scrollview.padding * 2



            }
        }

        function addGraphicsCard(provider){
            var comp;
            var card;

            //create cards and pass info
            comp = Qt.createComponent("subclass/GraphicsCard.qml")

            if (comp.status == Component.Ready){
                card = comp.createObject(col,{"cardIndex":provider.getIndex(), "provider" : provider })
            }
            else{
                comp.statusChanged.connect(  createGraphicsCard(provider, comp));
            }

        }

        function createGraphicsCard(provider, comp){
            var card
            card = comp.createObject(col,{"cardIndex":provider.getIndex(), "provider" : provider })

        }


}
