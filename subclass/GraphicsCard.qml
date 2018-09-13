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

    property DataProvider provider: null


    Component.onCompleted: {
        graph.provider = provider
    }

    Component.onDestruction: {
        provider.finished()
    }

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

           CustomSwitch{
                id: armedSwitch
                //Layout.alignment: Qt.AlignBottom
                widthValue: 35
                onClicked: {
                    provider.setArmed(on)
                    if(!on) status.textValue = "Status : Offline"
                    else status.textValue = "Status : "+provider.getStatus() ;
                }
           }

            Label {
                id: minerIndex
                text: "Miner "+ cardIndex
                font.pixelSize: Qt.application.font.pixelSize * 1.9
                color: Literals.fontcolor
                font.weight: Literals.fontWeightLarger
                verticalAlignment: Text.AlignBottom

            }



            HorizontalSpacer {
            }

            Rectangle {
                    implicitHeight: 16
                    implicitWidth: 16
                    color: Literals.transparent
                    border.color: Literals.borderColor
                    border.width: Literals.borderWidth
                    radius: 2
                    Layout.rightMargin: -1
                    Layout.topMargin: -5

                    Text {
                        id: name
                        text: qsTr( "▲")
                        anchors.centerIn: parent
                        font.pixelSize: Qt.application.font.pixelSize * .6
                        color: Literals.borderColor
                    }
                }


              //  text: "▲"
            }

        Item{
            implicitHeight: 20
            width: 2
        }
        ///////////////////////////////////////////////////////////////////////////////  top row
        ///////////////////////////////////////////////////////////////////////////////  card Content
        RowLayout {

            Layout.fillWidth: true
            Pane {
                padding: 0
                Layout.preferredWidth: 120
                background: Rectangle {
                    color: "transparent"
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
                            Label {
                                /*space*/ }
                        }
                    }
                }
            }
            ColumnLayout {
                id: columnRight
                Layout.fillWidth: true

                GraphItem {
                    id: graph
                    myIndex: cardIndex
                    onCardnameChanged: cardName.textValue = graph.cardname;
                    onStatusChanged: armedSwitch.on? status.textValue = "Status : "+provider.getStatus() : status.textValue = "Status : Offline" ;
                    onHighChanged: high.textValue = "High ("+graph.currentTime+") : "+graph.high.toString()
                    onLowChanged: low.textValue = "Low ("+currentTime+") : "+graph.low.toString()
                    onMeanChanged: mean.textValue = "Mean : "+graph.mean.toString()
                    onLatestChanged: latest.textValue = "Latest : "+ graph.latest.toString()
                    onArmedChanged: graph.armed == true? armedSwitch.checked = true : armedSwitch.checked = false;
                }
            }
        }
    }
}
