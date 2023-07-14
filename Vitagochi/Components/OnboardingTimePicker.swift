//
//  OnboardingTimePicker.swift
//  Vitagochi
//
//  Created by Dzulfikar on 13/07/23.
//

import SwiftUI

struct OnboardingTimePicker: View {
    private var hourSpacing: CGFloat = CGFloat(35)
    private var minuteSpacing: CGFloat = CGFloat(35)
    private var periodSpacing: CGFloat = CGFloat(22)
    
    @Binding var selectedHour: Int
    @Binding var hours: [Int]
    
    @Binding var selectedMinute: Int
    @Binding var minutes: [Int]
    
    @Binding var selectedPeriod: Int
    
    private var periods: [String] = ["AM", "PM"]
    
    init(selectedHour: Binding<Int>, hours: Binding<[Int]>, selectedMinute: Binding<Int>, minutes: Binding<[Int]>, selectedPeriod: Binding<Int>,  hourSpacing: CGFloat = CGFloat(35), minuteSpacing: CGFloat = CGFloat(35), periodSpacing: CGFloat = CGFloat(22)) {
        self.hourSpacing = hourSpacing
        self.minuteSpacing = minuteSpacing
        self.periodSpacing = periodSpacing
        self._selectedHour = selectedHour
        self._hours = hours
        self._selectedMinute = selectedMinute
        self._minutes = minutes
        self._selectedPeriod = selectedPeriod
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                VerticalPicker($selectedHour, items: hours) { value in
                    GeometryReader { reader in
                        Text((value.description.count == 1) ? "0\(value)" : "\(value)")
                            .font(.system(size: 48.0))
                            .fontWeight(.bold)
                            .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                    }
                }
                .height(.Fixed(hourSpacing))
                .scrollAlpha(0.2)
                .scrollScale(0.6)
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                
                Text(":")
                    .font(.system(size: 48.0))
                    .fontWeight(.bold)
                    .frame(maxWidth: geometry.size.width / 3, maxHeight: geometry.size.height)
                
                VerticalPicker($selectedMinute, items: minutes) { value in
                    GeometryReader { reader in
                        Text((value.description.count == 1) ? "0\(value)" : "\(value)")
                            .font(.system(size: 48.0))
                            .fontWeight(.bold)
                            .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                    }
                }
                .height(.Fixed(minuteSpacing))
                .scrollAlpha(0.2)
                .scrollScale(0.6)
                .frame(maxWidth: geometry.size.width / 3, maxHeight: geometry.size.height)
                
                VerticalPicker($selectedPeriod, items: periods) { value in
                    GeometryReader { reader in
                        Text((value.description.count == 1) ? "0\(value)" : "\(value)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                    }
                }
                .height(.Fixed(periodSpacing))
                .scrollAlpha(0.2)
                .scrollScale(0.8)
                .frame(maxWidth: geometry.size.width / 3, maxHeight: geometry.size.height)
            }
            
        }
    }
}

struct OnboardingTimePicker_Previews: PreviewProvider {
    
    static var previews: some View {
        OnboardingTimePicker(selectedHour: .constant(10), hours: .constant(Array(0...11)) , selectedMinute: .constant(5), minutes: .constant(Array(0...59)), selectedPeriod: .constant(0))
    }
}
