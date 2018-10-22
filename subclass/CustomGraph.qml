import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import DataProvider 1.0

Pane {

    id: control
    property int xaxiscount: 15
    property int yaxiscount: 6
    property int numOfValues: 0
    property string graphAxisColor: "#22ffffff"
    property string graphFillColor: "#33ffffff"
    property string graphLineColor: "#66ffffff"
    property int xAxisMaxMultiplier: 2
    property bool skipgraph: false
    property string backgroundColor: "#777"
    property DataProvider provider: null
    property int animate: 0


    padding: 0

    background: Rectangle {
        color: "#06888888"
        border.color: Literals.borderColor
        border.width: Literals.borderWidth

    }

    anchors.fill: parent

    Connections{
        target: provider
        onDataAdded:{
            canvas.requestPaint()
        }
    }

    function reDraw() {
        canvas.requestPaint()
    }

    MouseArea {
        anchors.fill: parent
        id: area

        onClicked: {
            provider.randomSeries()
        }

 //       onMouseXChanged: {
            //            if ((mouseX % (width / numOfValues) | 0) == 0) {

            //                //      console.log(( mouseX / (width/32) | 0 ))
            //                var list = provider.getValues()
            //                var x1
            //                // var y1
            //                for (var i = 0; i < list.length; i++) {
            //                    var d1 = list[i]
            //                    x1 = i * width / numOfValues
            //                    if ((mouseX | 0) == x1) {

            //                        console.log(d1)
            //                        var y1 = (1.0 - d1 / 100) * height
            //                        console.log("yaxis ", (y1 | 0))

            //                    //    canvas.drawInfoNode(x1, y1)
            //                    //    canvas.markDirty()
            //                    }
            //                }
            //            }
    }


    Canvas {
        id: canvas
        anchors.fill: parent

        smooth: true
        antialiasing: true

        onPaint: {

            var ctx = canvas.getContext("2d")
            var list = provider.getValues()
            ctx.lineWidth = .5
            //draw grid
            ctx.clearRect(0, 0, width, height)
            drawGrid()

            //draw points
            drawPoints(list)

            //draw values
            drawValues()
        }

        function drawGrid() {
            var ctx = canvas.getContext("2d")

            ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.strokeStyle = graphAxisColor

            for (var i = 0; i < yaxiscount + 1; i++) {
                ctx.beginPath()
                ctx.moveTo(0, i * height / yaxiscount)
                ctx.lineTo(width, i * height / yaxiscount)
                ctx.stroke()
            }

            for (var i = 0; i < xaxiscount + 1; i++) {
                ctx.beginPath()
                ctx.moveTo(i * width / xaxiscount-animate, 0)
                ctx.lineTo(i * width / xaxiscount-animate, height)
                ctx.stroke()
            }
            animate+= 3;
            if(animate>=(width/xaxiscount)) animate =0;
            ctx.strokeStyle = graphAxisColor

            ctx.moveTo(0,0)

        }
        function drawPoints(list) {
            var ctx = canvas.getContext("2d")

            ctx.moveTo(-3, height)


            var ytop = height/2
            var ybottom = height-5
            var ydiff = ytop - ybottom;
            var min = provider.getLow()
            var max = provider.getHigh() //* control.xAxisMaxMultiplier
            var diff = max - min
            if(diff <.5) diff = .5;

            for (var i = 0; i < list.length; i++) {
                var d1 = list[i]
                var x1 = i * width / (numOfValues + 1)
             //   var y1 = (1.0 - d1 / max) * height
             //   ctx.lineTo(x1, y1)

                var yr = 1.0 - ((d1 - min) / diff);
                var y1 =ybottom + yr * ydiff;

                ctx.lineTo(x1,y1)

            }
      //      ctx.strokeStyle = "#bb45da67"
            ctx.stroke()
            ctx.shadowBlur = 0.0
            ctx.shadowColor = "#00333888"

            //fill path under graph
            ctx.strokeStyle = "#223344"
            ctx.lineTo(x1, height)
            ctx.lineTo(list[0], height)
            ctx.fillStyle = "#bb45da67"
            ctx.fill()
        }

        function drawInfoNode(x, y) {
            var ctx = canvas.getContext("2d")
            ctx.fillStyle = "#55333333"
            ctx.fillRect(x + 10, y + 5, 50, 30)
        }

        function drawValues(){
            drawXValues()
            drawYValues()
        }

        function drawXValues(){

        }

        function drawYValues(){
            var ctx = canvas.getContext("2d")
            ctx.moveTo(0,height)

        }
    }
}
