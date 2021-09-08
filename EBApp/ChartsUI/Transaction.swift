//
//  Transaction.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 9/6/21.
//

import Charts
import Foundation

struct Transaction {
    enum ItemType {
        case itemAch, itemLM, itemTrg, none
    }
    var xValue: Double
    var yValue: Double
    var itemType: ItemType
//    var allTransactions:[Transaction]

//    static var selectedItem = Transaction(xValue: -1, yValue: -1, itemType: .none, allTransactions)
//
//    static var selectedItem2 = Transaction(xValue: -1, yValue: -1, itemType: .none)
//    static func initialItem(year: Int) -> Transaction {
//        Transaction(xValue: -1, yValue: -1, itemType: .none)
//    }
    static var xValueArray = ["Jan","Feb","Mar","Apr","May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    static func transactionsForYear(_ year: Int, transactions: [Transaction], itemType:ItemType = .itemAch) -> [BarChartDataEntry] {
        let yearData = transactions.filter{$0.itemType == itemType}
        return yearData.map{BarChartDataEntry(x: $0.xValue, y: $0.yValue * (itemType == ItemType.itemLM ? -1 : 1))}
    }

    static func lineChartDataForYear(_ year: Int, transactions: [Transaction], itemType:ItemType = .itemAch) -> [ChartDataEntry] {
        let yearData = transactions.filter{$0.itemType == itemType}
        return yearData.map{BarChartDataEntry(x: $0.xValue, y: $0.yValue)}
    }
    
}
