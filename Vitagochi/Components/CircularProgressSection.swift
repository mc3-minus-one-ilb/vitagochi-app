//
//  CricularProgressSection.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

struct CircularProgressSection: View {
    var dayNumber: Int
    var mealRecords: [MealRecordEntity] = []
    var phasesStatus: [VitaTimePhase] = []
    var isLocked: Bool
    var isHighlighted: Bool
    
    init(dayNumber: Int, mealRecords: [MealRecordEntity], isLocked: Bool, isHighlighted: Bool) {
        self.dayNumber = dayNumber
        self.mealRecords = mealRecords
        self.isLocked = isLocked
        self.isHighlighted = isHighlighted
        for record in mealRecords.sorted(by: {$0.timeStatus < $1.timeStatus}) {
            self.phasesStatus.append(VitaTimePhase(rawValue: record.timeStatus)!)
        }
    }
    
    var body: some View {
        VStack {
            if isLocked {
                ZStack {
                    Track(size: CGSize(width: 40, height: 40),
                          colors: [.gray3],
                          lineWidth: 4,
                          defaultBackgroundColor: true,
                          defaultTrackColor: false)
                    
                    Image(systemName: "lock.fill")
                        .resizable()
                        .frame(width: 12, height: 18)
                        .foregroundColor(.gray3)
                }
                
            } else {
                
                ZStack(alignment: .center) {
                    CircularProgressDetailedView(
                        phasesStatus: phasesStatus,
                        lineWitdh: 4)
                    if phasesStatus.count < 3 {
                        Text("\(phasesStatus.count)/3")
                            .font(.caption2)
                            .fontWeight(.regular)
                    } else  {
                        Image(systemName: "hand.thumbsup.fill")
                            .resizable()
                            .frame(width: 17, height: 16)
                            .foregroundColor(.mintPrimary)
                    }
                }
                
            }
            
            HStack(alignment: .top) {
                if isHighlighted {
                    Rectangle()
                        .foregroundColor(.mintPrimary)
                        .frame(width: 4, height: 8)
                        .cornerRadius(8)
                        .offset(x: 1, y: 4)
                }
                
                Text("Day \(dayNumber)")
                    .font(.caption2)
                    .fontWeight(isHighlighted ? .bold : .regular)
                    .foregroundColor(isHighlighted ? .blackBase : isLocked ? .gray2 : .black)
                    .padding(.top, 4)
                    .offset(x: -3)
                
            }
            
        }
    }
}

struct CircularProgressDetailedView: View {
    var phasesStatus: [VitaTimePhase] = []
    var lineWitdh: CGFloat = 4
    
    var body: some View {
        //        GeometryReader { geometry in
        ZStack {
            
            Track(size: CGSize(width: 40, height: 40),
                  lineWidth: lineWitdh,
                  defaultBackgroundColor: true,
                  defaultTrackColor: false)
            
            if phasesStatus.count == 3 {
                Image(systemName: "sparkles")
                    .resizable()
                    .frame(width: 5, height: 7)
                    .foregroundColor(.yellowAccent1)
                    .offset(x: -3, y: -26)
                
                Image(systemName: "sparkles")
                    .resizable()
                    .frame(width: 7, height: 8)
                    .foregroundColor(.yellowAccent1)
                    .offset(x: 25, y: 12)
                
                Image(systemName: "sparkles")
                    .resizable()
                    .frame(width: 5, height: 6)
                    .foregroundColor(.yellowAccent1)
                    .offset(x: -22, y: 16)
            }
            
            if !phasesStatus.isEmpty {
                ForEach(0...phasesStatus.count-1, id: \.self) { index in
                    DetailedOutline(phase: phasesStatus[index],
                                    size: CGSize(width: 40, height: 40),
                                    lineWidth: lineWitdh,
                                    index: index)
                }
            }
        }
        .frame(width: 40, height: 40)
        //        }
    }
}

struct DetailedOutline: View {
    var phase: VitaTimePhase
    var size: CGSize
    var lineWidth: CGFloat
    var index: Int
    
    var body: some View {
        var degrees = 280
        if index == 1 {
            degrees = 41
        } else if index == 2 {
            degrees = 160
        }
        
        var colors: [Color] = [Color.mintAccent2]
        if phase == .morning {
            colors = [Color.pinkAccent]
        } else if phase == .afternoon {
            colors = [Color.yellowAccent2]
        }
        return ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: size.width, height: size.height)
                .overlay(
                    Circle()
                        .trim(from: 0, to: 25 * 0.01)
                        .stroke(style:
                                    StrokeStyle(lineWidth: lineWidth,
                                                lineCap: .round,
                                                lineJoin: .round)
                               )
                        .fill(
                            AngularGradient(gradient: .init(colors: colors),
                                            center: .top,
                                            startAngle: .init(degrees: 150),
                                            endAngle: .init(degrees: 360)
                                           )
                        )
                    // 270
                    // 37
                    // 150
                        .rotationEffect(.init(degrees: Double(degrees)))
                )
                .animation(
                    .spring(response: 2.0,
                            dampingFraction: 1.0,
                            blendDuration: 1.0),
                    value: 25
                )
        }
    }
}

struct CricularProgressSection_Previews: PreviewProvider {
    static var previews: some View {
        let coreDataSingleton = CoreDataEnvirontment.singleton
        let mealRecords = coreDataSingleton.challenges.first!.records?.allObjects as? [MealRecordEntity]
        CircularProgressSection(dayNumber: 1, mealRecords: mealRecords!, isLocked: false, isHighlighted: true)
    }
}
