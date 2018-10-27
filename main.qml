import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "subclass"
import MinerManager 1.0
import DataProvider 1.0

Page {
    visible: true
    width: 640
    height: 480
    title: qsTr("Jahminer")
    minimumHeight: 350
    minimumWidth: 460
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


    color: Literals.darkBackgroundColor
    background: Rectangle {
        color: Literals.darkBackgroundColor
    }




    ColorOverlay{
        id: indicator

        Behavior on x {
            NumberAnimation{
                duration: 200
            }
        }

        implicitHeight: chartBtn.height
        implicitWidth: chartBtn.width
        color: "#fff"
        opacity: 0.1
        z: 100
        anchors.top: toolbar.top

        state: "graph"

        states: [
            State {
                name: "graph"
                PropertyChanges {
                    target: indicator
                    x : chartBtn.x
                }
            },
            State {
                name: "pool"
                PropertyChanges {
                    target: indicator
                    x : poolBtn.x
                }
            },
            State {
                name: "help"
                PropertyChanges {
                    target: indicator
                    x : help1Btn.x
                }
            }

        ]
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
                implicitWidth: 0
                color: Literals.borderColor
                anchors.left: parent.left
            }
            Rectangle{
                id: rightRect
                implicitHeight: parent.height
                implicitWidth: 0
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
                    indicator.state = "graph"
                }
            }
            ToolBarButton {
                id: poolBtn
                textValue: "Pool"
                imageSource: "images/settings-40.png"
                onClicked: {
                    swipe.state = "settings"
                    bottonButtonPane.state = "settings"
                    indicator.state = "pool"
                }
            }

            ToolBarButton {
                id: help1Btn
                textValue: "Help"
                imageSource: "images/help.png"
                visible: true
                onClicked: {
                    swipe.state = "help"
                    indicator.state = "help"
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

            MouseArea{
                anchors.fill: parent
                property variant previousPosition
                    onPressed: {
                        previousPosition = Qt.point(mouseX, mouseY)
                        console.log(previousPosition)
                    }
                    onPositionChanged: {
                        if (pressedButtons == Qt.LeftButton) {
                            var dx = mouseX - previousPosition.x
                            var dy = mouseY - previousPosition.y
                            app.pos = Qt.point(viewerWidget.pos.x + dx,
                                                        viewerWidget.pos.y + dy)
                        }
                    }
            }

            id: swipe
            Layout.fillHeight: true
            Layout.fillWidth: true

            border.color: Literals.borderColor
            border.width: Literals.borderWidth
            color: Literals.darkBackgroundColor

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
                onSave: {
                   swipe.state = "graph";
                    indicator.state = "graph"
                   bottonButtonPane.state  = "";

                   manager.setWalletId(settings_page.walletid);
                   manager.setPoolUrl(settings_page.poolurl);
                   manager.setPassword(settings_page.password)
                   manager.setIdentifier(settings_page.identifier)
                   manager.saveAndApplySettings();
                }

                onCancel: {
                    manager.resetSettings();

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

                    PropertyChanges{
                        target: bottonButtonPane
                        implicitHeight: .5
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

                    PropertyChanges{
                        target: bottonButtonPane
                        implicitHeight: .5
                    }
                }
            ]
        }

        Pane {
            id: bottonButtonPane
            Layout.fillWidth: true

            Behavior on implicitHeight{
                NumberAnimation{
                    duration: 100
                }
            }

            background: Rectangle {
                color: Literals.darkBackgroundColor
                border.color: Literals.borderColor
                border.width: 0
            }

            leftPadding: 20
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
                        if(!startMining) graph_page.status = "Inactive"
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

//            states: [
//                State {
//                    name: "settings"
//                    PropertyChanges {
//                        target: startBtn
//                        textValue: "Confirm"
//                       onClicked:{
//                           swipe.state = "graph";
//                           bottonButtonPane.state  = "";

//                           manager.setWalletId(settings_page.walletid);
//                           manager.setPoolUrl(settings_page.poolurl);
//                           manager.setPassword(settings_page.password)
//                           manager.setIdentifier(settings_page.identifier)
//                           manager.saveAndApplySettings();
//                       }
//                    }

//                    PropertyChanges {
//                        target: helpBtn
//                        textValue: "Canel"
//                        onClicked:{
//                            manager.resetSettings();
//                        }

//                    }
//                }

//            ]
        }
    }
}
