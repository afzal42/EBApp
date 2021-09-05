//
//  XCalenderView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/28/21.
//

import SwiftUI

struct XCalenderView: View {
    @Binding var date: Date 
    @Binding var x : CGFloat
    
    private let calendar: Calendar = .current
    private let colors = CalendarColors(
        chevron: .black,
        currentMonth: .black,
        weekday: .init(circle: .blue, text: .black),
        current: .init(circle: .white, text: .black),
        other: .init(circle: .gray, text: .black),
        selected: .init(circle: .orange, text: .black)
    )

    var body: some View {
        VStack {
            MonthCalendarView(x:$x, date: $date, calendar: calendar, colors: colors)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40)
        .background(Color.white)
        .cornerRadius(5)
        .offset(x: 0, y: 0)
    }
}

//Afzal Hossain
