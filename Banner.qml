import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Pane {

    background: Rectangle {
        color: Literals.transparent
    }

    id: logo
    padding: 9
    RowLayout {
        anchors.fill: parent

        Image {
            id: bannerImage
            //    source: "images/jahminer icon.png"
            source: "images/icon.ico"
            sourceSize.width: parent.height
            sourceSize.height: parent.height
        //    width: 130; height: 100
            fillMode: Image.PreserveAspectFit

        }

        ColumnLayout {
            spacing: 1
            Label {
                id: title
                width: 68
                height: 39
                color: Literals.fontcolor
                Layout.fillHeight: true
                verticalAlignment: Text.AlignVCenter
                text: qsTr("  JAHSHAKA")
                font.weight: Literals.fontWeightLarger
                font.pixelSize: Qt.application.font.pixelSize * 1.9
            }
            Label {
                id: titleMiner
                width: 68
                height: 23
                color: Qt.lighter(Literals.fontcolor,1.5)
                Layout.fillHeight: true
                verticalAlignment: Text.AlignVCenter
                text: qsTr("  MINER")
                font.weight: Literals.fontWeightLighter
                font.pixelSize: Qt.application.font.pixelSize * 1
                Layout.leftMargin: 6
               // Layout.topMargin: -2
            }
        }
    }
}
