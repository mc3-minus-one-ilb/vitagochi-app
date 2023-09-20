//
//  InformationSheetView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 31/08/23.
//

import SwiftUI

struct InformationSheetView: View {
    let listBottomPadding: CGFloat = 36
    let indicatorTraillingPadding: CGFloat = 12
    var body: some View {
        VStack(alignment: .leading) {
            Text("Information ✨")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 40)
                .padding(.top, 80)
            Group {
                HStack {
                    Text("0/3")
                        .frame(width: 40)
                        .padding(.trailing, indicatorTraillingPadding)
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundColor(.blackBase)
                    
                    Text("You haven’t ")
                    + Text("eat any meal ").fontWeight(.semibold)
                    + Text("on that day")
                }
                .padding(.bottom, listBottomPadding)
                
                HStack {
                    Text("1/3")
                        .frame(width: 40)
                        .padding(.trailing, indicatorTraillingPadding)
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundColor(.blackBase)
                    Text("You've already eat ")
                    + Text("once ").fontWeight(.semibold)
                    + Text("a day")
                }
                .padding(.bottom, listBottomPadding)
                HStack {
                    Text("2/3")
                        .frame(width: 40)
                        .padding(.trailing, indicatorTraillingPadding)
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundColor(.blackBase)
                    Text("You've already eat ")
                    + Text("twice ").fontWeight(.semibold)
                    + Text("a day")
                }
                .padding(.bottom, listBottomPadding)
                HStack {
                    ZStack {
                        CircularProgressDetailedView(phasesStatus: [.morning, .afternoon, .evening])
                        Image(systemName: "hand.thumbsup.fill")
                            .resizable()
                            .frame(width: 17, height: 16)
                            .foregroundColor(.mintPrimary)
                    }
                    .padding(.trailing, indicatorTraillingPadding)
                    Text("You've accomplished a task to eat")
                    + Text("\n3 times ").fontWeight(.semibold)
                    + Text("a day")
                }
                .padding(.bottom, listBottomPadding)
                
                HStack {
                    CircularProgressDetailedView(phasesStatus: [.morning])
                        .padding(.trailing, indicatorTraillingPadding)
                    Text("Pink color indicate you've already have")
                    + Text("\nbreakfast").fontWeight(.semibold)
                }
                .padding(.bottom, listBottomPadding)
                HStack {
                    CircularProgressDetailedView(phasesStatus: [.afternoon])
                        .padding(.trailing, indicatorTraillingPadding)
                    Text("Yellow color indicate you've already have")
                    + Text("\nlunch").fontWeight(.semibold)
                }
                .padding(.bottom, listBottomPadding)
                HStack {
                    CircularProgressDetailedView(phasesStatus: [.evening])
                        .padding(.trailing, indicatorTraillingPadding)
                    Text("Green color indicate you've already have")
                    + Text("\ndinner").fontWeight(.semibold)
                }
                .padding(.bottom, listBottomPadding)
            }
            Spacer()
        }
        .font(.subheadline)
        .kerning(-0.8)
        .foregroundColor(.blackGreen)
    }
}

struct InformationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        InformationSheetView()
    }
}
