import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
Label {
    property string textValue: ""
    property real opacityValue: 0.95

    TextMetrics{
        id: textMetrics
        font.weight: Literals.fontWeight
         font.pixelSize: Qt.application.font.pixelSize * 1.2
    }

    id: latest
    text: qsTr(textValue)
    Layout.fillWidth: true
    horizontalAlignment: Text.AlignRight
    font: textMetrics.font
    color: Literals.fontcolor
    opacity: opacityValue
}
