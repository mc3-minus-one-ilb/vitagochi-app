//
//  ProgressListView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

struct ProgressListView: View {
    @Binding var selection: Int
    let items = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]
    let gridItems = [GridItem(.flexible()),GridItem(.flexible()),
                     GridItem(.flexible()), GridItem(.flexible()),
                     GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItems) {
                ForEach(items, id: \.self) { item in
                    CircularProgressSection(dayNumber: item, progress: 2, isLocked: false)
                        .padding(.vertical, 10)
                }
            }
            .padding(.horizontal)
            .padding(.top, 74)
        }
        
    }
}

struct ProgressListView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressListView(selection: .constant(0))
    }
}
