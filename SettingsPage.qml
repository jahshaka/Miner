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
    leftPadding: 15
    rightPadding: 15
    bottomPadding : 10
    topPadding: 0

    background: Rectangle{
        border.width: Literals.borderWidth
        border.color: Literals.borderColor
        color : Literals.transparent
    }


    Label{
        id: label
        anchors.top: parent.top
        anchors.left: parent.left
        text: qsTr("Settings")
        padding: 7
        leftPadding: 0
        bottomPadding: 11
        color: "#fff"
        font.pixelSize: Qt.application.font.pixelSize * 1.8
        font.weight: Literals.fontWeightLarger
    }

    ScrollView {
        id: scroll
       // anchors.fill: parent
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: label.bottom
        }

        background: Rectangle {
            color: Literals.darkBackgroundColor
            border.width: 1
            border.color: Literals.borderColor
        }


        ColumnLayout {
            id: col
            spacing: 10
            width: scroll.width
       //     height: scroll.height - 20
            Item {
                id: space
                implicitHeight: 10
            }

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
