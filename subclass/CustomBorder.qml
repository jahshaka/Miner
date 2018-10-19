import QtQuick 2.0

Rectangle
{

    property bool commonBorder : true
    property string borderColor : "white"


    property int lBorderwidth : 10
    property int rBorderwidth : 0
    property int tBorderwidth : 0
    property int bBorderwidth : 0

    property int commonBorderWidth : 1

    //z : -1
    implicitWidth: 1



    color: Literals.transparent

    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom

        topMargin    : commonBorder ? -commonBorderWidth : -tBorderwidth
        bottomMargin : commonBorder ? -commonBorderWidth : -bBorderwidth
        leftMargin   : commonBorder ? -commonBorderWidth : -lBorderwidth
        rightMargin  : commonBorder ? -commonBorderWidth : -rBorderwidth
    }
}
