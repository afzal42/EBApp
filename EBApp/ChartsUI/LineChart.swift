//
//  LineChart.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 9/6/21.
//
//
//import Foundation
//
///// Interface that allows custom formatting of all values inside the chart before they are drawn to the screen.
/////
///// Simply create your own formatting class and let it implement ValueFormatter. Then override the stringForValue()
///// method and return whatever you want.
//
//@objc(IChartValueFormatter)
//public protocol IValueFormatter: class
//{
//
//    /// Called when a value (from labels inside the chart) is formatted before being drawn.
//    ///
//    /// For performance reasons, avoid excessive calculations and memory allocations inside this method.
//    ///
//    /// - Parameters:
//    ///   - value:           The value to be formatted
//    ///   - dataSetIndex:    The index of the DataSet the entry in focus belongs to
//    ///   - viewPortHandler: provides information about the current chart state (scale, translation, ...)
//    /// - Returns:                   The formatted label ready to be drawn
//    func stringForValue(_ value: Double,
//                        entry: ChartDataEntry,
//                        dataSetIndex: Int,
//                        viewPortHandler: ViewPortHandler?) -> String
//}
//
///// An interface for providing custom axis Strings.
//@objc(IChartAxisValueFormatter)
//public protocol IAxisValueFormatter: class
//{
//
//    /// Called when a value from an axis is formatted before being drawn.
//    ///
//    /// For performance reasons, avoid excessive calculations and memory allocations inside this method.
//    ///
//    /// - Parameters:
//    ///   - value:           the value that is currently being drawn
//    ///   - axis:            the axis that the value belongs to
//    /// - Returns: The customized label that is drawn on the x-axis.
//    func stringForValue(_ value: Double,
//                        axis: AxisBase?) -> String
//
//}

import Charts
import SwiftUI


final class MyDsValueFmt: IValueFormatter{
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        
        let number = value
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000

        if billion >= 1.0 {//        return "\(round(billion*10)/10)B"
            return String(format: "%.1f", ((billion*10)/10))+"B"
        } else if million >= 1.0 {//        return "\(round(million*10)/10)M"
            return String(format: "%.1f", ((million*10)/10))+"M"
        } else if thousand >= 1.0 {//        return ("\(round(thousand*10/10))K")
            return String(format: "%.1f", ((thousand*10)/10))+"K"
        } else {
            return "\(Int(number))"
        }
    }
    
}


final class MyLeftAxisValueFmt: IAxisValueFormatter{
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let number = value
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000

        if billion >= 1.0 {//        return "\(round(billion*10)/10)B"
            return String(format: "%.1f", ((billion*10)/10))+"B"
        } else if million >= 1.0 {//        return "\(round(million*10)/10)M"
            return String(format: "%.1f", ((million*10)/10))+"M"
        } else if thousand >= 1.0 {//        return ("\(round(thousand*10/10))K")
            return String(format: "%.1f", ((thousand*10)/10))+"K"
        } else {
            return "\(Int(number))"
        }
    }
    
    
}

struct LineChart: UIViewRepresentable {
    // NOTE: No Coordinator or delegate functions in this example
    let lineChart = LineChartView()
    var entriesAch : [ChartDataEntry] // there is no LineChartDataEntry as I would have expected
    let LineXString: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.noDataText = "No Data"
        setChartData(uiView)
        configureChart(uiView)
        formatXAxis(xAxis: uiView.xAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
//        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }
    
    func setChartData(_ lineChart: LineChartView) {
        let dataSetAch = LineChartDataSet(entries: entriesAch)
        let dataSets: [LineChartDataSet] = [dataSetAch]
        let lineChartData = LineChartData(dataSets: dataSets)
        lineChart.data = lineChartData
        formatDataSet(dataSet: dataSetAch, label: "", fill: true, color: .blue)
    }
    
    func formatDataSet(dataSet: LineChartDataSet, label: String, fill: Bool, color: UIColor) {
//        dataSet.label = label
        dataSet.label = "X=KPI, Y=Growth%"
        dataSet.colors = [color]
        dataSet.valueColors = [color]
        dataSet.circleColors = [color]
        dataSet.circleRadius = 0
        dataSet.circleHoleRadius = 0
        dataSet.mode = .linear
        dataSet.lineWidth = 2
        dataSet.drawValuesEnabled = true
        dataSet.drawFilledEnabled = fill
//        dataSet.drawCirclesEnabled = true
//        dataSet.lineDashLengths = [4]
//        let format = NumberFormatter()
//        format.numberStyle = .decimal
//        dataSet.valueFormatter = MyDsValueFmt() //DefaultValueFormatter(formatter: format)
//        dataSet.valueFont = UIFont.systemFont(ofSize: 12)
    }

    func configureChart(_ lineChart: LineChartView) {
//        lineChart.drawGridBackgroundEnabled = false
//        lineChart.gridBackgroundColor = UIColor.white
        lineChart.drawBordersEnabled = false
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.drawAxisLineEnabled = false
        lineChart.leftAxis.drawAxisLineEnabled = false
        lineChart.legend.enabled = true
        
//        lineChart.setScaleEnabled(false)
//        lineChart.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
//        if lineChart.scaleX == 1.0 {
//            lineChart.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
//        }
            lineChart.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
        let marker:BalloonMarker = BalloonMarker(color: UIColor.gray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75, height: 35)
        lineChart.marker = marker
    
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        let format = NumberFormatter()
        format.numberStyle = .none
//        xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: format)
        xAxis.valueFormatter = IndexAxisValueFormatter(values:LineXString)
        xAxis.labelTextColor =  .black
        xAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
        // Setting the max and min make sure that the markers are visible at the edges
//        xAxis.axisMaximum = 31
//        xAxis.axisMinimum = 0
        xAxis.labelRotationAngle=270
        xAxis.drawAxisLineEnabled = false
    }
    
    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = MyLeftAxisValueFmt()
//        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelTextColor =  .black
        leftAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
        leftAxis.drawAxisLineEnabled = false
    }

    func formatLegend(legend: Legend) {
        legend.textColor = UIColor.black
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 20.0
    }
}
