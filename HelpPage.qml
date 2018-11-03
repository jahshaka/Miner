import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "subclass"


BasePage {

    padding: 10


    Rectangle{
        id: rect
        implicitWidth: parent.width
        implicitHeight: 75
        visible: true
        color: Literals.transparent
        RowLayout{
            anchors.fill: parent
            Text {
                id: name
                Layout.fillWidth: true
                color: "#eeffffff"
                text: qsTr("Get started with mining monero! \n 1. Create a Monero wallet at MyMonero if you dont have one \n 2. Sign up for a mining account on the SupportXMR mining pool\n 3. Enter your data on the settings page")
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 1.4

            }
        }
    }
    ScrollView {
        id: scrollview
        width: parent.width
        anchors.top: rect.bottom
        height: parent.height - 55 - rect.height
       // Layout.fillWidth: true
        Layout.fillHeight: true
        ScrollBar.horizontal.policy : ScrollBar.AlwaysOff
        background: Rectangle{
            border.width: Literals.borderWidth
            border.color: Literals.borderColor
            color : Literals.transparent
        }

        clip: true
        padding: 10

        GridLayout {

            id: col
            //spacing:5
            columns: 1
            width: scrollview.width- scrollview.padding * 2
       //     height: scrollview.height - scrollview.padding * 2



            Item {

                implicitHeight: 9
            }

            ParagraphLink{
                id: wallet
                explanation: "Create a monero wallet at MyMonero if you don't have one"
                labelText: "Create Wallet"
                linkText: "Create"
                onClicked: {
                    Qt.openUrlExternally("https://mymonero.com/#/")
                }
            }

            ParagraphLink{
                id: createAccount
                explanation: "Sign up for a mining account on the Support XMR mining pool"
                labelText: "Create Mining Account"
                linkText: "Create"
                onClicked: {
                    Qt.openUrlExternally("https://www.supportxmr.com/#/home")
                }
            }


            ParagraphLink{
                id: onlineHelp
                explanation: "Cick to get help online from jahfx"
                labelText: "Online Assistance"
                linkText: "Help"
                enabled: false
                visible : false
                onClicked: {
                    Qt.openUrlExternally("https://www.jahfx.com/")
                }
            }

            ParagraphLink{
                id: support
                explanation: "Get assistance with using the Jahshaka Miner online"
                labelText: "Online Assistance"
                linkText: "help"
                enabled: true
                visible: true
                onClicked: {
                    Qt.openUrlExternally("https://www.jahshaka.com/miner/")
                }
            }
            Item {
                //width: 15
                implicitHeight: 45
            }

        }
    }

}
