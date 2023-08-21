//
//  CollectiveDayTimePicker.swift
//  Vitagochi
//
//  Created by Dzulfikar on 17/07/23.
//

import SwiftUI

enum CollectiveDayEating: String {
    case BREAKFAST
    case LUNCH
    case DINNER
}

extension CollectiveDayEating {
    var iconLabel: String {
        switch self {
        case.BREAKFAST:
            return "sun.and.horizon.fill"
        case.LUNCH:
            return "cloud.sun.fill"
        case.DINNER:
            return "moon.stars.fill"
        }
    }
    
    var textLabel: String {
        switch self {
        case.BREAKFAST:
            return "Breakfast"
        case.LUNCH:
            return "Lunch"
        case.DINNER:
            return "Dinner"
        }
    }
}

struct CollectiveDayTimePicker: View {
    @Binding var timeSelection: Date
    
    var collectiveDayEating: CollectiveDayEating = .BREAKFAST
    var minHour: Int
    var maxHour: Int
    var hasDivider: Bool
    
    init(timeSelection: Binding<Date>, collectiveDayEatingType: CollectiveDayEating, minHour: Int, maxHour: Int, hasDivider: Bool = true) {
        self._timeSelection = timeSelection
        self.collectiveDayEating = collectiveDayEatingType
        self.minHour = minHour
        self.maxHour = maxHour
        self.hasDivider = hasDivider
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8.0) {
                Image(systemName: collectiveDayEating.iconLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 65, height: 60)
                VStack(alignment: .leading, spacing: 8) {
                    Text(collectiveDayEating.textLabel)
                        .font(.headline)
                    DatePicker("", selection: $timeSelection, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .background(Color.primaryColor)
                        .cornerRadius(8.0)
                        .frame(alignment: .leading)
                        .tint(.black)
                        .onChange(of: timeSelection, perform: { date in
                            let calendar = Calendar.current
                            let hour = calendar.component(.hour, from: date)
                            if !(minHour...maxHour).contains(hour) {
                                let clampedDate = calendar
                                    .date(bySettingHour: minHour,
                                          minute: 0,
                                          second: 0,
                                          of: date)!
                                timeSelection = clampedDate
                            }
                        })
                }
                .frame(alignment: .leading)
            }
            
            if hasDivider {
                Rectangle()
                    .frame(width: 3, height: 74)
                    .cornerRadius(5)
                    .foregroundColor(Color(uiColor: UIColor("D4D4D4")))
                    .padding(.horizontal, 32.0)
            }
        }
    }
}

struct CollectiveDayTimePicker_Previews: PreviewProvider {
    
    struct CollectiveDayTimePicker_Previewer: View {
        @State var breakfastSelection = Calendar
            .current.date(bySettingHour: 7,
                          minute: 0,
                          second: 0,
                          of: .now)!
        @State var lunchSelection = Calendar
            .current.date(bySettingHour: 12,
                     minute: 0,
                     second: 0,
                     of: .now)!
        @State var dinnerSelection = Calendar
            .current.date(bySettingHour: 17,
                          minute: 0,
                          second: 0,
                          of: .now)!
        var body: some View {
            VStack {
                CollectiveDayTimePicker(timeSelection: $breakfastSelection,
                                        collectiveDayEatingType: .BREAKFAST,
                                        minHour: 7,
                                        maxHour: 11)
                
                CollectiveDayTimePicker(timeSelection: $lunchSelection,
                                        collectiveDayEatingType: .LUNCH,
                                        minHour: 12,
                                        maxHour: 15)
                    .padding([.vertical], 16.0)
                
                CollectiveDayTimePicker(timeSelection: $dinnerSelection,
                                        collectiveDayEatingType: .DINNER,
                                        minHour: 17,
                                        maxHour: 21,
                                        hasDivider: false)
            }
        }
    }
    
    static var previews: some View {
        CollectiveDayTimePicker_Previewer()
    }
}
