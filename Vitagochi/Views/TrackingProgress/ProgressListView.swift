//
//  ProgressListView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

struct ProgressListView: View {
    @EnvironmentObject var envObj: GlobalEnvirontment
    @EnvironmentObject var coreDataEnv: CoreDataEnvirontment
    @State var items: [ChallangeEntity] = []
    
    let gridItems = [GridItem(.flexible()),GridItem(.flexible()),
                     GridItem(.flexible()), GridItem(.flexible()),
                     GridItem(.flexible()), GridItem(.flexible())]
    
    var selection: Int
    var daysCount: Int
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItems) {
                ForEach(items) { item in
                    
                    CircularProgressSection(dayNumber: Int(item.day), progress: item.records?.count ?? 0, isLocked: Int(item.day) > daysCount)
                        .padding(.vertical, 10)
                        .onTapGesture {
                            if !(Int(item.day) > daysCount) {
                                envObj.path.append(item)
                            }
                        }
                    
                }
            }
            .padding(.horizontal,16)
            .padding(.top, 92)
        }
        .navigationDestination(for: ChallangeEntity.self) { challange in
            DetailTrackingView(challange: challange)
        }
        .onAppear{
            items = coreDataEnv.getChallangeBasedOnSection(section: selection)
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
