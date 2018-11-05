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

    implicitHeight: width/2.4
    implicitWidth: widthValue  * 1.1
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
        color: "#efefef"

        Behavior on x{
            NumberAnimation{
                duration: 120
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            if(!on){
                groove.state = "on"
                groove.clicked()
            }else{
                groove.state = "off"
                groove.clicked()
            }
        }

        onEntered: {
            handle.color = Qt.darker("#efefef", 1.05)
            cursorShape = Qt.PointingHandCursor

        }

        onExited: {
            handle.color = "#efefef"
            cursorShape = Qt.ArrowCursor
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
