//
//  Date+Extend.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

extension Date {
    func isPhaseGreaterThan(_ value: VitachiTimePhase) -> Bool {
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        
        var inputDateComponent = DateComponents()
        inputDateComponent.hour = value.time.hour
        inputDateComponent.minute = value.time.minute
        
        if let inputDate = calendar.date(byAdding: inputDateComponent, to: calendar.date(from: currentDateComponents)!) {
//            print("Date \(inputDate) and \(self)")
            return self > inputDate
        }
        
        return false
    }
    
    func isItTodayOrPast(date: Date) -> Bool {
        var calendar = Calendar.current
        let today = calendar.startOfDay(for: self)
        let inputDate = calendar.startOfDay(for: date)
        
        return inputDate <= today
    }
    
    func increaseDate(by days: Int) -> Date? {
        var calendar = Calendar.current
        let dateComponent = DateComponents(day: days)
        return calendar.date(byAdding: dateComponent, to: self)
    }
    
    func isItToday(date: Date) -> Bool {
        var calendar = Calendar.current
        let currentDateComp =  calendar.dateComponents([.year, .month, .day], from: self)
        let compareDateComp = calendar.dateComponents([.year, .month, .day], from: date)
        return currentDateComp == compareDateComp
    }
    
    func isPhaseAfterOneHour(_ value: VitachiTimePhase) -> Bool {
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        
        var inputDateComponent = DateComponents()
        inputDateComponent.hour = value.time.hour + 1
        inputDateComponent.minute = value.time.minute
        
        if let inputDate = calendar.date(byAdding: inputDateComponent, to: calendar.date(from: currentDateComponents)!) {
//            print("Date \(inputDate) and \(self)")
            return self > inputDate
        }
        
        return false
    }
}
