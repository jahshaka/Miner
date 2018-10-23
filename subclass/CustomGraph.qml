import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import DataProvider 1.0

Pane {

    id: control
    property int xaxiscount: 15
    property int yaxiscount: 5
    property int numOfValues: 0
    property string graphAxisColor: "#22ffffff"
    property string graphFillColor: "#33ffffff"
    property string graphLineColor: "#66ffffff"
    property int xAxisMaxMultiplier: 2
    property bool skipgraph: false
    property string backgroundColor: "#777"
    property DataProvider provider: null
    property int animate: 0
    property int canvasXStartPosition: 29
    property int canvasHeight : height - 20
    property int currentHeight : height

    property int graphHeightOffset : 7
    property bool drawText : true




    padding: 0

    background: Rectangle {
        color: "#00888888"
        border.color: Literals.transparent
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
            ctx.clearRect(0, 0, width, height)

            //fill Rectangle
            ctx.fillStyle = "#06888888"
            ctx.fillRect(canvasXStartPosition, 0 , width- canvasXStartPosition, canvasHeight)


            //draw outline
            ctx.strokeStyle = "#bbffffff"
            ctx.strokeRect(canvasXStartPosition, 0 , width- canvasXStartPosition, canvasHeight)

            //draw grid

            drawGrid()

            //draw points
            drawPoints(list)

            //draw values
            if(drawText)   drawValues()
        }

        function drawGrid() {
            var ctx = canvas.getContext("2d")

            ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.strokeStyle = graphAxisColor

            for (var i = 1; i < yaxiscount ; i++) {
                ctx.beginPath()
                ctx.moveTo(canvasXStartPosition, i * canvasHeight / yaxiscount)
                ctx.lineTo(width, i * canvasHeight / yaxiscount)
                ctx.stroke()
            }

            for (var i = 0; i < xaxiscount + 1; i++) {
                ctx.beginPath()
                ctx.moveTo(i * width / xaxiscount-animate + canvasXStartPosition, 0)
                ctx.lineTo(i * width / xaxiscount-animate + canvasXStartPosition, canvasHeight)
                if(i*width/xaxiscount-animate + canvasXStartPosition > canvasXStartPosition)
                ctx.stroke()
            }

            if(false) animate += 2;
            if(animate>=(width/xaxiscount)+canvasXStartPosition) animate =0;
            ctx.strokeStyle = graphAxisColor

        }
        function drawPoints(list) {
            var ctx = canvas.getContext("2d")

            ctx.moveTo(canvasXStartPosition, canvasHeight)


            var ytop = canvasHeight/2 + graphHeightOffset
            var ybottom = canvasHeight + 2
            var ydiff = ytop - ybottom;
            var min = provider.getLow()
            var max = provider.getHigh() //* control.xAxisMaxMultiplier
            var diff = max - min
            var offset = 3
            if(diff <.5) diff = .5;

            for (var i = 0; i < list.length; i++) {
                var d1 = list[i]
                var x1 = (i * (width - canvasXStartPosition) / (numOfValues + 1 )) + canvasXStartPosition

                var yr = ((d1 - min) / diff);
                var y1 =ybottom + yr * ydiff;

                ctx.lineTo(x1,y1 - offset)

            }
            ctx.stroke()
            ctx.shadowBlur = 0.0
            ctx.shadowColor = "#00333888"

            //fill path under graph
            ctx.strokeStyle = "#223344"
            ctx.lineTo(x1, canvasHeight)
            ctx.lineTo(list[0], canvasHeight)
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
            var offset = 3
            var max = provider.getHigh()
            var interval = max / 2
                ctx.font = "9px arial"
            ctx.fillStyle = "#99ffffff"
            for (var i = 1; i <= yaxiscount ; i++)
            {

                var text = (interval * (5 - i) ).toFixed(0)
                var fontWidth =  ctx.measureText(text ).width
                console.log(fontWidth)
                ctx.fillText(text , 23 - fontWidth, i * (canvasHeight) / yaxiscount +offset)
            }

        }
    }
}
