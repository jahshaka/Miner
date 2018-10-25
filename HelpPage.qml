import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "subclass"


BasePage {

    padding: 10
    background: Rectangle {
        color: Literals.darkBackgroundColor
    }

    ScrollView {
        id: scrollview
        width: parent.width
        height: parent.height
       // Layout.fillWidth: true
        Layout.fillHeight: true
        ScrollBar.horizontal.policy : ScrollBar.AlwaysOff

        clip: true
        padding: 10

        background: Rectangle {
            color: Literals.darkBackgroundColor
        }


        GridLayout {

            id: col
            //spacing:5
            columns: 2
            width: scrollview.width- scrollview.padding * 2
       //     height: scrollview.height - scrollview.padding * 2

            ParagraphLink{
                id: createAccount
                explanation: "click the button above to create an account on xmr stak"
                labelText: "Create Mining Account"
                linkText: "Create"
                onClicked: {
                    Qt.openUrlExternally("https://www.supportxmr.com/#/home")
                }
            }

            ParagraphLink{
                id: wallet
                explanation: "click the button to build the configurations"
                labelText: "Create Wallet"
                linkText: "Create"
                onClicked: {
                    Qt.openUrlExternally("https://mymonero.com/#/")
                }
            }

            ParagraphLink{
                id: onlineHelp
                explanation: "click the button to get help online from jahfx"
                labelText: "Online Assistance"
                linkText: "Help"
                onClicked: {
                    Qt.openUrlExternally("https://www.jahfx.com/")
                }
            }

            ParagraphLink{
                id: support
                explanation: "click the button to support Jahshaka by visiting www.jahshaka.com"
                labelText: "Support Jahshaka"
                linkText: "Visit"
                onClicked: {
                    Qt.openUrlExternally("https://www.jahshaka.com/")
                }
            }

        }
    }

}
