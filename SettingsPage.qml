import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import "subclass"

//import "settings"
BasePage {

    property alias walletid: walletNode.textValue
    property alias poolurl: poolNode.textValue
    property alias password: passwordNode.textValue
    property alias identifier: identifierNode.textValue


    padding: 10

    background: Rectangle {
        color: Literals.darkBackgroundColor
    }

    ScrollView {
        id: scroll
        width: parent.width
        height: parent.height
        Layout.fillWidth: true
        Layout.fillHeight: true
        background: Rectangle {
            color: Literals.darkBackgroundColor
        }

        ColumnLayout {
            id: col
            spacing: 1
            width: scroll.width

            Item {
                Layout.fillHeight: true
            }

            SettingsNode {
                id: walletNode
                labeld: "Walled ID"
                iconPath: "images/wallet.png"
            }

            SettingsNode {
                id: poolNode
                labeld: "Pool Address"
                iconPath: "images/mailbox.png"

            }

            SettingsNode {
                id: identifierNode
                labeld: "Identifier"
                iconPath: "images/badge.png"

            }

            SettingsNode {
                id: passwordNode
                labeld: "Rig Name"
                iconPath: "images/lock.png"

            }

            Item {
                Layout.fillHeight: true
            }

        }
    }
}
