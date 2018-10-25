import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import DataProvider 1.0

Page {
    property alias cardName: cardName.textValue
    property alias status: status.textValue
    property alias high: high.textValue
    property alias low: low.textValue
    property alias mean: mean.textValue
    property alias latest: latest.textValue
    property int cardIndex: 0
    property bool maximized: true
    property bool showLogs : false


    property DataProvider provider: null

    id: page

    Connections{
        target: provider
        onMinerOutput:{
            log.append(text)
        }
    }



    Component.onCompleted: {
        graph.provider = provider

    }

    Component.onDestruction: {
        provider.finished()
    }

    onMaximizedChanged: {
        page.state= maximized==true? "maximize" : "minimize"
    }

    onShowLogsChanged: {

    }



    state: "maximize"
    states: [
        State {
            name: "maximize"
            PropertyChanges {
                target: statistics
            //    visible: true
                opacity: 1.0

            }


        }, State {
            name: "minimize"
            PropertyChanges {
                target: statistics
           //     visible: false
                opacity: 0.0
                implicitHeight: 60
                implicitWidth: 0

            }
            PropertyChanges {
                target: graphRowLayout

                Layout.margins: {
                    topMargin: -15
                }
            }

            PropertyChanges {
                target: graph
                drawText :false
                customheight : graph.currentheight
                spaceHeight : 0
            }
        }
    ]



    padding: 15
    topPadding: 10
    Layout.fillWidth: true
    background: Rectangle {
        color: "#00000000"
        border.color: "#555555"
        border.width: 2
    }

    TextMetrics {
        id: textMetrics
        font.weight: Literals.fontWeight
        font.pixelSize: Qt.application.font.pixelSize * 1.2
    }

    ColumnLayout {
        id: colLayout
        anchors.fill: parent
        ////////////////////////////////////////////////////////////////////////// top row
        RowLayout {
            anchors {
                left: parent.left
                right: parent.right
            }

            CustomSwitch {
                id: armedSwitch
                //Layout.alignment: Qt.AlignBottom
                widthValue: 35
                onClicked: {
                    provider.setArmed(on)
                    if (!on)
                        status.textValue = "Status : Offline"
                    else
                        status.textValue = "Status : " + provider.getStatus()
                }

            }

            Label {
                id: minerIndex
                text: "Miner " + cardIndex
                font.pixelSize: Qt.application.font.pixelSize * 1.9
                color: Literals.fontcolor
                font.weight: Literals.fontWeightLarger
                verticalAlignment: Text.AlignBottom
            }

            HorizontalSpacer {
            }

            Button {
                implicitHeight: 16
                implicitWidth: 16

                Layout.rightMargin: -1
                Layout.topMargin: -5
                background: Rectangle {

                    color: Literals.transparent
                    border.color: Literals.borderColor
                    border.width: Literals.borderWidth
                    radius: 2
                }

                Text {
                    id: name
                    text: qsTr("▲")
                    anchors.centerIn: parent
                    font.pixelSize: Qt.application.font.pixelSize * .6
                    color: Literals.borderColor
                }
                onClicked: {
                    maximized = maximized==true? false:true;
                }
            }
        }

        Item {
            implicitHeight: 20
            width: 2
        }
        ///////////////////////////////////////////////////////////////////////////////  top row
        ///////////////////////////////////////////////////////////////////////////////  card Content
        RowLayout {
            id: graphRowLayout
            Layout.fillWidth: true

            Behavior on Layout.margins {
                NumberAnimation{
                    duration: 400
                }
            }

            Pane {
                id: statistics

                Behavior on opacity {
                    NumberAnimation{
                        duration: 220
                    }
                }

                Behavior on implicitHeight{
                    NumberAnimation{
                        duration: 420
                    }
                }
                Behavior on implicitWidth {
                    NumberAnimation{
                        duration: 420
                    }
                }


                padding: 0
              //  Layout.preferredWidth: 120
                background: Rectangle {
                    color: Literals.transparent
                    implicitWidth: 80
                }

                ColumnLayout {
                    id: columnLeft
                    anchors.fill: parent
                    Layout.preferredWidth: 100
                    Layout.fillWidth: true
                    Pane {
                        padding: 0
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "#00000000"
                        }
                        ColumnLayout {
                            anchors.fill: parent
                            SimpleLabel {
                                id: cardName
                                Layout.fillWidth: true
                                textValue: "CardOne"
                            }
                            SimpleLabel {
                                id: status
                                textValue: "status"
                            }
                            Label {
                                /*space*/ }
                            SimpleLabel {
                                id: high
                                textValue: "high"
                                opacityValue: .75
                                font.weight: Literals.fontWeightLighter
                            }
                            SimpleLabel {
                                id: low
                                textValue: "low"
                                opacityValue: .75
                                font.weight: Literals.fontWeightLighter
                            }
                            SimpleLabel {
                                id: mean
                                textValue: "mean"
                                opacityValue: .75
                                font.weight: Literals.fontWeightLighter
                            }
                            SimpleLabel {
                                id: latest
                                textValue: "latest"
                                opacityValue: .75
                                font.weight: Literals.fontWeightLighter
                            }
                            Label {
                                /*space*/ }
                            RowLayout{
                                Layout.fillWidth: true
                                Item {
                                    id: space1
                                    Layout.fillWidth: true
                                }
                                LogButton {
                                    id: logBtn
                                    textValue: "Logs"
                                    onClicked: {
                                      //  graphRowLayout.state = "back"
                                        showLogs = !showLogs
                                    }
                                }
                            }
                            Label {
                                /*space*/ }
                            Label {
                                /*space*/ }

                        }
                    }
                }
            }
            ColumnLayout {
                id: columnRight
                Layout.fillWidth: true


                Flipable{
                    id: flip
                    anchors.fill: parent
                    front: GraphItem {
                        id: graph
                        anchors.fill: parent
                        myIndex: cardIndex
                        onCardnameChanged: cardName.textValue = graph.cardname
                        onStatusChanged: armedSwitch.on ? status.textValue = "Status : "
                                                          + provider.getStatus(
                                                              ) : status.textValue = "Status : Offline"

    //                    onHighChanged: high.textValue = "High (" + graph.currentTime + ") : " + graph.high.toString()
    //                    onLowChanged: low.textValue = "Low (" + currentTime + ") : " + graph.low.toString()

                        onHighChanged: high.textValue = "High " + graph.high.toString()
                        onLowChanged: low.textValue = "Low " + graph.low.toString()

                        onMeanChanged: mean.textValue = "Mean : " + graph.mean.toString()
                        onLatestChanged: latest.textValue = "Latest : " + graph.latest.toString()
                        onArmedChanged: graph.armed == true ? armedSwitch.checked
                                                              = true : armedSwitch.checked = false

                    }
                    back: LogPage{
                        id: log
                        onGoback:{
                            showLogs = false;
                        }
                        onCopy: {
                            provider.saveMinerOutput()
                        }
                    }

                    // flippable continues

                    transform: Rotation {
                            id: rotation
                            origin.x: columnRight.width/2
                            origin.y: columnRight.height/2
                            axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                            angle: 0    // the default angle
                        }



                    states: State {
                            name: "back"
                            PropertyChanges { target: rotation; angle: 180 }
                            when: showLogs
                        }

                        transitions: Transition {
                            NumberAnimation { target: rotation; property: "angle"; duration: 200 }
                        }
                }

            }
        }
    }
}
