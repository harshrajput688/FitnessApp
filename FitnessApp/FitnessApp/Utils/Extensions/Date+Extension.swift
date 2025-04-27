//
//  Date+Extension.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 12/02/25.
//

import Foundation

extension Date{
    static var startOfDay: Date{
        return Calendar.current.startOfDay(for: Date())
    }
    static var startOfWeek: Date{
        let calendar = Calendar.current
        var component = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        component.weekday = 2
        return calendar.date(from: component) ?? Date()
    }
    
    func fetchMonthStartAndEndDate()->(Date, Date){
        let calender = Calendar.current
        let startDateComponent = calender.dateComponents( [.year, .month], from: calender.startOfDay(for: self))
        let startDate = calender.date(from: startDateComponent) ?? self
        let endDate = calender.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) ?? Date()
        return (startDate, endDate)
    }
    func formatWorkOutdate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self)
    }
}
