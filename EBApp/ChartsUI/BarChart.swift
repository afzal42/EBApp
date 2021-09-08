//
//  BarChart.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 9/7/21.
//

import Charts
import SwiftUI


struct BarChart: UIViewRepresentable {

    let entries: [BarChartDataEntry]
    let BarXString: [String]
    
    let barChart = BarChartView()
    
    func makeUIView(context: Context) -> BarChartView {
        barChart.delegate = context.coordinator
        return barChart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.label = "X=KPI, Y=Growth%"
        uiView.noDataText = "No Data"
        uiView.data = BarChartData(dataSet: dataSet)
        uiView.rightAxis.enabled = false
//        if uiView.scaleX == 1.0 {
//            uiView.zoom(scaleX: 1.5, scaleY: 0.5, x: 0, y: 0)
//        }
        uiView.setScaleEnabled(true)
        formatDataSet(dataSet: dataSet)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatXAxis(xAxis: uiView.xAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent:BarChart
        init(parent: BarChart) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//            let month = BarXString[Int(entry.x)]
//            let quantity = Int(entry.y)
//            parent.selectedItem = "\(quantity) sold in \(month)"
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func formatDataSet(dataSet: BarChartDataSet) {
        dataSet.colors = [.blue]
        dataSet.valueColors = [.blue]
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
    }
    
    func formatLeftAxis(leftAxis: YAxis) {
        leftAxis.labelTextColor = .blue
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
//        leftAxis.axisMinimum = -500
//        leftAxis.axisMaximum = 500
    }
    
    func formatXAxis(xAxis: XAxis) {
        xAxis.valueFormatter = IndexAxisValueFormatter(values: BarXString)
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = .blue
        xAxis.labelRotationAngle = 270
        xAxis.drawAxisLineEnabled = false
        
    }
    
    func formatLegend(legend: Legend) {
        legend.textColor = .blue
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 20.0
        
    }
   
}


