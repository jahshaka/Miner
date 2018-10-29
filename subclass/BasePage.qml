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
    property real commonWidth : 0

    background: Rectangle {
        color: Literals.darkBackgroundColor
        border.width: Literals.borderWidth
        border.color: Literals.borderColor
    }

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
        anchors.left: parent.left

        color: borderColor
        implicitWidth: commonWidth
        implicitHeight: parent.height
        z:10
        //visible: showHorizontalBorders || showAllBorders

    }
    Rectangle{
        id: rightrect
        anchors.right: parent.right
        color: Literals.borderColor
        implicitWidth: commonWidth
        implicitHeight: parent.height
        z:10
        //visible: showHorizontalBorders || showAllBorders

    }
    Rectangle{
        id: toprect
        anchors.top : parent.top
        color: borderColor
        implicitWidth: parent.width
        implicitHeight: commonWidth
        z:10
        //visible: showVerticalBorders || showAllBorders

    }
    Rectangle{
        id: bottomrect
        anchors.bottom: parent.bottom
        color: Literals.borderColor
        implicitWidth: parent.width
        implicitHeight: commonWidth
        z:10
        //visible: showVerticalBorders || showAllBorders

    }
}
/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

