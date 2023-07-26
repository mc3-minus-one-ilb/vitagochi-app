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
    
    func isDateYesterday(_ date: Date?) -> Bool {
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: self)!
        if let date = date {
            return calendar.isDate(date, inSameDayAs: yesterday)
        }
        return false
    }
    
    func isItTodayOrPast(date: Date) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: self)
        let inputDate = calendar.startOfDay(for: date)
        
        return inputDate <= today
    }
    
    func isItPast(date: Date) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: self)
        let inputDate = calendar.startOfDay(for: date)
        return inputDate < today
    }
    
    func getFormattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        return formatter.string(from: self)
    }
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d yyyy"

        return dateFormatter.string(from: self)
    }
    
    func increaseDate(by days: Int) -> Date? {
        let calendar = Calendar.current
        let dateComponent = DateComponents(day: days)
        return calendar.date(byAdding: dateComponent, to: self)
    }
    
    func isItToday(date: Date) -> Bool {
        let calendar = Calendar.current
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
