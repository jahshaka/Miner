import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
Rectangle {
    id:groove
    property int widthValue: 50
    property int offset: 4
    property bool checked: false
    property bool on: false
    property string bgcolor: checked ? Literals.switchOnColor : Literals.switchOffColor
    signal clicked()

    implicitHeight: width/2.5
    implicitWidth: widthValue
    color: bgcolor
    border.color: Literals.borderColor
    border.width: 1
    radius: height

    Component.onCompleted: {
        groove.clicked()
    }

    Behavior on bgcolor{
        ColorAnimation {
            duration: 120
        }
    }

    Rectangle{
        id:handle
        implicitWidth: groove.height - offset
        implicitHeight: width
        radius: width/2
        x:offset
        y: offset/2
        color: Literals.buttonColor

        Behavior on x{
            NumberAnimation{
                duration: 120
            }
        }

    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            if(!on){
//                handle.x = groove.width - handle.width - offset
//                checked = true
//                on = true
                groove.state = "on"
                groove.clicked()
            }else{
//                handle.x = offset
//                checked = false
//                on = false
                groove.state = "off"
                groove.clicked()
            }
        }
    }

    state: "on"

    states: [
        State {
            name: "on"
            PropertyChanges {
                target: groove
                checked : true
                on : true
            }
            PropertyChanges {
                target: handle
                x : groove.width - width - offset
            }
        },
        State {
            name: "off"
            PropertyChanges {
                target: groove
                checked : false
                on : false
            }
            PropertyChanges {
                target: handle
                x : offset
            }
        }
    ]

 }
