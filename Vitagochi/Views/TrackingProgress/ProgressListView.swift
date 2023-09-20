//
//  ProgressListView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

struct ProgressListView: View {
    @EnvironmentObject private var envObj: GlobalEnvirontment
    @EnvironmentObject private var coreDataEnv: CoreDataEnvirontment
    @State var items: [ChallangeEntity] = []
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible()),
                     GridItem(.flexible()), GridItem(.flexible()),
                     GridItem(.flexible()), GridItem(.flexible())]
    
    var selection: Int
    var daysCount: Int
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(items) { item in
                    let day = Int(item.day)
                    let mealRecords = item.records?.allObjects as? [MealRecordEntity]
                   
                    CircularProgressSection(dayNumber: day,
                                            mealRecords: mealRecords!,
                                            isLocked: day > daysCount,
                                            isHighlighted: day == daysCount)
                        .padding(.vertical, 10)
                        .onTapGesture {
                            if !(Int(item.day) > daysCount) {
                                envObj.path.append(item)
                            }
                        }
                        .fontDesign(.rounded)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 92)
        }
        .navigationDestination(for: ChallangeEntity.self) { challenge in
            DetailTrackingView(challenge: challenge)
        }
        .onAppear {
            items = coreDataEnv
                .getChallangeBasedOnSection(section: selection)
        }
    }
    
}

struct ProgressListView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressListView(selection: 0, daysCount: 2)
            .environmentObject(CoreDataEnvirontment.singleton)
            .environmentObject(GlobalEnvirontment.singleton)
    }
}
