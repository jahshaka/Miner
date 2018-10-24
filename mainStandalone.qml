import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
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


        layer.enabled: true
           layer.effect: DropShadow {
               transparentBorder: true
               horizontalOffset: 0
               verticalOffset: 8
               color: "#44000000"
               radius: 12.0
           }

        //padding : 5
        background: Rectangle {
            color: Literals.darkBackgroundColor
            border.color: Literals.borderColor
            border.width: 0

            Rectangle{
                id: leftRect
                implicitHeight: parent.height
                implicitWidth: 2
            color: Literals.borderColor
                anchors.left: parent.left
            }
            Rectangle{
                id: rightRect
                implicitHeight: parent.height
                implicitWidth: 2
                color: "#555"
                anchors.right: parent.right
            }
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
                id: help1Btn
                textValue: "Help"
                imageSource: "images/help.png"
                visible: true
                onClicked: {
                    swipe.state = "help"
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

            HelpPage {
                id: help_page
                anchors.fill: parent
                z:0
                scale : 0.0
                opacity : 0.0
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
                },
                State {
                    name: "help"
                    PropertyChanges {
                        target: help_page
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
                    id: jahshakaLabel
                    Layout.fillWidth: true
                    text: "Support Jahshaka\nwww.jahshaka.com"
                    horizontalAlignment: Text.AlignHCenter
                    color: Literals.fontcolor
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                    font.weight: Literals.fontWeight
                    visible: false
                    MouseArea{

                        anchors.fill: parent
                        hoverEnabled:  true
                        onClicked: {
                            Qt.openUrlExternally("https://www.jahshaka.com/")
                        }
                        onEntered: {
                            jahshakaLabel.color = Literals.blueButtonColor
                        }
                        onExited: {
                            jahshakaLabel.color = "#eeffffff"
                        }

                    }
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
                BlueButton {
                    id: helpBtn
                    textValue: "Help"
                    visible: false
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
