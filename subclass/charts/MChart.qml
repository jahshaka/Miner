/*******************************************************************************
Copyright (C) 2017 Milo Solutions
Contact: https://www.milosolutions.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*******************************************************************************/


import QtQuick 2.0

import "Chart.js" as Charts

Chart {

    property var labels

    property var values

    property color color

    property var colors

    property color fillColor: "#00ffffff"

    property color strokeColor

    property color pointColor

    property int max_value: 100// max value for y-axis
    property int step_width: 5  //number of horizontal lines
    property int cartwidth: width


    /*!
     * Converts chart data to suitable format for Bar and RADAR charts.
     */
    function prepareBarChartData() {
        return {
            labels: labels,
            datasets: [
                {
                    fillColor: color,
                    data: values
                }
            ]
        }
    }

    /*!
     * Converts chart data to suitable format for PIE, DOUGHNUT and POLAR charts.
     */
    function preparePieChartData() {
        if (labels.length !== values.length || labels.length !== colors.length) {
            console.exception("To use Pie chart labels/values/colors should have the same size")
            return
        }

        var chartData = []
        for (var i = 0 ; i < labels.length ; ++i) {
            chartData.push({
                               label: labels[i],
                               value: values[i],
                               color: colors[i]
                           })
        }
        return chartData
    }

    /*!
     * Converts chart data to suitable format for LINE chart.
     */
    function prepareLineChartData() {
        return {
            labels: labels,
            datasets: [
                {
                    data: values,
                    fillColor: fillColor,
                    fill:true,
                    strokeColor: strokeColor,
                    pointColor: pointColor,
                }
            ]
        }
    }

    chartAnimationEasing: Easing.OutCubic
    chartAnimationDuration: 300

    chartOptions: ({
                       "scaleLineWidth": 0,
                       "barShowStroke": false,
                       "scaleFontSize": 10,
                       "scaleFontFamily": "sans-serif",
                       "barValueSpacing": 10,
                       "scaleFontColor": "#444444",
                       "pointDotRadius": 0,
                       "bezierCurve": false,
                       "scaleGridLineColor": Literals.borderColor,
                       "scaleLineColor": "rgba(222,222,222,.1)",
                       "scaleShowLabels": false,
                       "scaleShowGridLines": false,
                       "scaleSteps": step_width,
                       "scaleStepWidth": max_value/step_width,
                       "scaleOverride": true
                   })
    onValuesChanged: {
        if (chartType === Charts.ChartType.BAR
                || chartType === Charts.ChartType.RADAR) {
            chartData = prepareBarChartData()
        } else if (chartType === Charts.ChartType.PIE
                   || chartType === Charts.ChartType.DOUGHNUT
                   || chartType === Charts.ChartType.POLAR) {
            chartData = preparePieChartData()
        } else if (chartType === Charts.ChartType.LINE) {
            chartData = prepareLineChartData()
        }


    }

    Component.onCompleted: {
        if (chartType === Charts.ChartType.BAR
                || chartType === Charts.ChartType.RADAR) {
            chartData = prepareBarChartData()
        } else if (chartType === Charts.ChartType.PIE
                   || chartType === Charts.ChartType.DOUGHNUT
                   || chartType === Charts.ChartType.POLAR) {
            chartData = preparePieChartData()
        } else if (chartType === Charts.ChartType.LINE) {
            chartData = prepareLineChartData()
        }
    }
}
