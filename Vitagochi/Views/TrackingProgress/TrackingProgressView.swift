//
//  TrackingProgressView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI



struct TrackingProgressView: View {
    @EnvironmentObject var coreDataEnv: CoreDataEnvirontment
    
    @StateObject var trackingModel = TrackingProgressViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Text("\(trackingModel.daysCount)")
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
            
            
            TabView(selection: $trackingModel.selection) {
                ProgressListView(selection: 0, daysCount: trackingModel.daysCount)
                    .tag(0)
                ProgressListView(selection: 1, daysCount: trackingModel.daysCount)
                    .tag(1)
                ProgressListView(selection: 2, daysCount: trackingModel.daysCount)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
//            .animation(.spring(), value: trackingModel.selection)
            .overlay(
                VStack{
                    HStack {
                        TabBarSection(selection: $trackingModel.selection, value: 0, text: "Part 1")
                            .transition(.slide)
                            .animation(.default, value: trackingModel.selection)
                        Spacer()
                        TabBarSection(selection: $trackingModel.selection, value: 1, text: "Part 2")
                            .transition(.slide)
                            .animation(.default, value: trackingModel.selection)
                        Spacer()
                        TabBarSection(selection: $trackingModel.selection, value: 2, text: "Part 3")
                            .transition(.slide)
                            .animation(.default, value: trackingModel.selection)
                    }
                    ZStack(alignment: trackingModel.rectPosition.alignment){
                        Rectangle()
                            .foregroundColor(.shadowEclipseColor)
                            .frame(height: 3)
                        
                        Rectangle()
                            .foregroundColor(.circularProgressOutline)
                            .frame(width: UIScreen.main.bounds.size.width / 3, height: 6)
                    }
                }
                    .background(Color.primaryWhite)
                    .padding(.top, 8)
                
                , alignment: .top)
            .background(Color.primaryWhite)
            .clipShape(RoundedShape(radius: 16))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("Background"))
        .onAppear{
            trackingModel.daysCount = coreDataEnv.countHowManyDaySinceStart()
        }
        .onChange(of: trackingModel.selection) { newValue in
            trackingModel.changeRectPosition(value: newValue)
        }
        .ignoresSafeArea()
    }
}

struct TrackingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingProgressView()
            .environmentObject(CoreDataEnvirontment.singleton)
    }
}
