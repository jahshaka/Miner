import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Page {
    antialiasing: true

    property string heading: ""


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






//    Rectangle{
//        id: leftrect
//        anchors.left: parent.left

//        color: borderColor
//        implicitWidth: commonWidth
//        implicitHeight: parent.height
//        z:10

//    }
//    Rectangle{
//        id: rightrect
//        anchors.right: parent.right
//        color: Literals.borderColor
//        implicitWidth: commonWidth
//        implicitHeight: parent.height
//        z:10

//    }
//    Rectangle{
//        id: toprect
//        anchors.top : parent.top
//        color: borderColor
//        implicitWidth: parent.width
//        implicitHeight: commonWidth
//        z:10

//    }
//    Rectangle{
//        id: bottomrect
//        anchors.bottom: parent.bottom
//        color: Literals.borderColor
//        implicitWidth: parent.width
//        implicitHeight: commonWidth
//        z:10

//    }
}


