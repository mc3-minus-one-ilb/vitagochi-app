//
//  Date+Extend.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

extension Date {
    func isPhaseGreaterThan(_ value: VitachiPhase) -> Bool {
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
    
    func isPhaseAfterOneHour(_ value: VitachiPhase) -> Bool {
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
