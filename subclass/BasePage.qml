import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Page {
    antialiasing: true

    property bool showHorizontalBorders: true
    property bool showVerticalBorders: false
    property bool showAllBorders: showHorizontalBorders && showVerticalBorders
    property int borderWidth: Literals.borderWidth + 19
    property string borderColor: Literals.borderColor


    Behavior on opacity {
        PropertyAnimation {
            duration: Literals.animationLengthShort
            easing.type: Easing.InOutCirc
        }
    }

    Behavior on scale {
        PropertyAnimation {
            duration: Literals.animationLengthShort
            easing.type: Easing.InOutCirc
        }
    }

    Rectangle{
        id: leftrect
        x:-padding
        y:-padding
        border.width: 55
        border.color: borderColor
        implicitWidth: 2
        implicitHeight: parent.height
        visible: showHorizontalBorders || showAllBorders

    }
    Rectangle{
        id: rightrect
        y:-padding
        x:parent.width+padding-width
        border.width: 55
        border.color: Literals.borderColor
        implicitWidth: 2
        implicitHeight: parent.height
        visible: showHorizontalBorders || showAllBorders

    }
    Rectangle{
        id: toprect
        x: -padding
        y:-padding
        border.width: 55
        border.color: borderColor
        implicitWidth: parent.width
        implicitHeight: 2
        visible: showVerticalBorders || showAllBorders

    }
    Rectangle{
        id: bottomrect
        y:parent.height + padding - height
        x:-padding
        border.width: 55
        border.color: borderColor
        implicitWidth: parent.width
        implicitHeight: 2
        visible: showVerticalBorders || showAllBorders

    }
}
/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

