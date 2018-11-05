import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import "subclass"

BasePage {
    id: page

    property alias walletid: walletNode.textValue
    property alias poolurl: poolNode.textValue
    property alias password: passwordNode.textValue
    property alias identifier: identifierNode.textValue

    signal save()
    signal cancel()
    padding: 10

    background: Rectangle {
        color: Literals.darkBackgroundColor
    }

    ScrollView {
        id: scroll
        anchors.fill: parent
        background: Rectangle {
            color: Literals.darkBackgroundColor
        }

        ColumnLayout {
            id: col
            spacing: 10
            width: scroll.width
       //     height: scroll.height - 20

            SettingsNode {
                id: walletNode
                shouldFillWidth: false
                labeld: "Wallet ID"
                iconPath: "images/wallet.png"
            }

            SettingsNode {
                id: poolNode
                labeld: "Pool Address "
                iconPath: "images/mailbox.png"

            }

            SettingsNode {
                id: passwordNode
                labeld: "Worker Name"
                iconPath: "images/badge.png"

            }

            SettingsNode {
                id: identifierNode
                labeld: "Email Address"
                iconPath: "images/lock.png"

            }

            Rectangle{
               implicitHeight: 40
               implicitWidth: parent.width
               color: Literals.transparent
               Layout.fillHeight: true
            }




            RowLayout{
                Layout.fillWidth: true

                Item {
                    id: name
                    Layout.fillWidth: true
                }

                LogButton{
                    id: save
                    textValue: "confirm"
                    textSize: 1.2
                    onClicked: {
                        page.save()
                    }
                }
                LogButton{
                    id: cancel
                    textValue: "cancel"
                    textSize: 1.2
                    onClicked: {
                        page.cancel()
                    }
                }

                Item {
                    implicitWidth: 9
                }
            }

        }
    }
}
