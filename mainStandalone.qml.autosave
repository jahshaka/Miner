import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "subclass"
import MinerManager 1.0
import DataProvider 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Jahminer")
    minimumHeight: 350
    minimumWidth: 450
    id: app

    property bool startMining : false

    onStartMiningChanged: {
        if(startMining)  manager.startMining()
        else manager.stopMining();
    }

    MinerManager{
        id: manager
        Component.onCompleted: {
            manager.initialize();
        }

        onProcessCreated: {
            graph_page.addGraphicsCard(provider);
        }

        onPoolUrlChanged: {settings_page.poolurl = value}
        onPasswordChanged: {settings_page.password = value}
        onWalletIdChanged: {settings_page.walletid = value}
        onIdentifierChanged: {settings_page.identifier = value}
    }


    background: Rectangle {
        color: Literals.darkBackgroundColor
    }

    header: ToolBar {
        id: toolbar

        //padding : 5
        background: Rectangle {
            color: Literals.darkBackgroundColor
            border.color: Literals.borderColor
            border.width: Literals.borderWidth
        }
        RowLayout {
            anchors.fill: parent
            spacing: 0
            Banner {
            }

            HorizontalSpacer {
            }

            ToolBarButton {
                id: chartBtn
                textValue: "Charts"
                imageSource: "images/chart-40.png"
                onClicked: {
                    swipe.state = "graph"
                    bottonButtonPane.state = ""
                }
            }
            ToolBarButton {
                id: poolBtn
                textValue: "Pool"
                imageSource: "images/settings-40.png"
                onClicked: {
                    swipe.state = "settings"
                    bottonButtonPane.state = "settings"
                }
            }

            ToolBarButton {
                id: accountBtn
                textValue: "Account"
                imageSource: "images/lock-40.png"
                onClicked: {

                }
            }
            Item {
                //width: 15
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Rectangle {
            anchors.fill: parent

            id: swipe
            Layout.fillHeight: true
            Layout.fillWidth: true

            border.color: Literals.borderColor
            border.width: Literals.borderWidth

            //color: "red"
            SettingsPage {
                id: settings_page
                anchors.fill: parent
                z: 0
                scale: 0.0
                opacity: 0.0

                Component.onCompleted: {
                    poolurl = manager.getPoolUrl()
                    password = manager.getPassword()
                    walletid = manager.getWalletId()
                    identifier = manager.getIdentifier()
                }
            }

            GraphicsCardPage {
                id: graph_page
                anchors.fill: parent
                z: 0
                scale: 0.0
                opacity: 0.0

            }



            state: "graph"

            states: [

                State {
                    name: "settings"
                    PropertyChanges {
                        target: settings_page
                        scale: 1.0
                        z: 3
                        opacity: 1.0
                    }
                },
                State {
                    name: "graph"
                    PropertyChanges {
                        target: graph_page
                        scale: 1.0
                        z: 3
                        opacity: 1.0
                    }
                }
            ]
        }

        Pane {
            id: bottonButtonPane
            Layout.fillWidth: true
            background: Rectangle {
                color: Literals.darkBackgroundColor
                border.color: Literals.borderColor
                border.width: Literals.borderWidth
            }

            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right

                BlueButton {
                    id: startBtn
                    textValue: "Start"
                    onClicked: {
                        startMining = !startMining
                        textValue = startMining? "Stop" : "Start"
                        manager.setShouldMining(startMining)
                    }
                }
                Label {
                    Layout.fillWidth: true
                    text: "Support Jahshaka\nwww.jahshaka.com"
                    horizontalAlignment: Text.AlignHCenter
                    color: Literals.fontcolor
                    font.pixelSize: Qt.application.font.pixelSize * .8
                    font.weight: Literals.fontWeight
                }
                BlueButton {
                    id: helpBtn
                    textValue: "Help"
                    onClicked: {
                    }
                }
            }

            states: [
                State {
                    name: "settings"
                    PropertyChanges {
                        target: startBtn
                        textValue: "Confirm"
                       onClicked:{
                           swipe.state = "graph";
                           bottonButtonPane.state  = "";

                           manager.setWalletId(settings_page.walletid);
                           manager.setPoolUrl(settings_page.poolurl);
                           manager.setPassword(settings_page.password)
                           manager.setIdentifier(settings_page.identifier)
                           manager.saveAndApplySettings();
                       }
                    }

                    PropertyChanges {
                        target: helpBtn
                        textValue: "Canel"
                        onClicked:{
                            manager.resetSettings();
                        }

                    }
                }

            ]
        }
    }
}
