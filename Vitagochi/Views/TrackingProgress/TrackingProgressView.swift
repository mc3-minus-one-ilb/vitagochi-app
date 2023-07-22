//
//  TrackingProgressView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

enum RectPosition: Int {
    case leading = 0
    case center = 1
    case trailing = 2
    
    var alignment: Alignment {
        switch self {
        case.leading:
            return Alignment.leading
        case.center:
            return Alignment.center
        case.trailing:
            return Alignment.trailing
        }
    }
}

struct TrackingProgressView: View {
    @State var selection: Int = 0
    @State var rectPosition: RectPosition = .leading
    var body: some View {
        VStack {
            VStack {
                Text("63")
                    .font(.system(.largeTitle, weight: .semibold))
                    .fontDesign(.rounded)
                Text("Day")
                    .font(.system(.title2, weight: .semibold))
                    .fontDesign(.rounded)
                    .padding(.bottom, 20)
                Text("Since you start to consume \n    greens and fruits in your meals 🎯")
                    .multilineTextAlignment(.center)
                    .font(.system(.body, weight: .regular))
                    .fontDesign(.rounded)
                    .padding(.bottom, 20)
            }
            .padding(.top, 90)
            Spacer()
            
            
            TabView(selection: $selection) {
                ProgressListView(selection: $selection)
                    .tag(0)
                ProgressListView(selection: $selection)
                    .tag(1)
                ProgressListView(selection: $selection)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 1.0), value: selection)
            .overlay(
                VStack{
                    HStack {
                        TabBarSection(selection: $selection, value: 0, text: "Part 1")
                            .transition(.slide)
                            .animation(.default, value: selection)
                        Spacer()
                        TabBarSection(selection: $selection, value: 1, text: "Part 2")
                            .transition(.slide)
                            .animation(.default, value: selection)
                        Spacer()
                        TabBarSection(selection: $selection, value: 2, text: "Part 3")
                            .transition(.slide)
                            .animation(.default, value: selection)
                    }
                    ZStack(alignment: rectPosition.alignment){
                        Rectangle()
                            .foregroundColor(.shadowEclipseColor)
                            .frame(height: 3)
                        
                        Rectangle()
                            .foregroundColor(.circularProgressOutline)
                            .frame(width: UIScreen.main.bounds.size.width / 3, height: 6)
                    }
                }
                    .padding(.top, 8)
                
                , alignment: .top)
            .background(Color.primaryWhite)
            .clipShape(RoundedShape(radius: 16))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("Background"))
        .onChange(of: selection) { newValue in
            withAnimation(.easeIn) {
                rectPosition = RectPosition(rawValue: newValue)!
            }
        }
        .ignoresSafeArea()
    }
}

struct TrackingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingProgressView()
    }
}
