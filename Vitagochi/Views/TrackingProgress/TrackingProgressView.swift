//
//  TrackingProgressView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

struct TrackingProgressView: View {
    @EnvironmentObject private var coreDataEnv: CoreDataEnvirontment
    
    @StateObject private var trackingModel = TrackingProgressViewModel()
    
    var body: some View {
        GeometryReader { geo  in
            VStack {
                VStack {
                    ZStack {
                        Button {
                            trackingModel.showingInformationSheet.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                                .resizable()
                        }
                        .frame(width: 20, height: 20)
                        .offset(x: geo.size.width/2.5, y: -35)
                        
                        Text("\(trackingModel.daysCount)")
                            .font(.system(.largeTitle, weight: .semibold))
                            .fontDesign(.rounded)
                    }
                    
                    Text("Day")
                        .font(.system(.title3, weight: .semibold))
                        .fontDesign(.rounded)
                        .padding(.bottom, 15)
                    Text("Since you start to consume \n    greens and fruits in your meals 🎯")
                        .multilineTextAlignment(.center)
                        .font(.system(.body, weight: .regular))
                        .fontDesign(.rounded)
                        .padding(.bottom, 20)
                    
                }
                .foregroundColor(.blackGreen)
                .padding(.top, 82)
                .padding(.bottom, 16)
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
                .animation(
                    .interpolatingSpring(mass: 1,
                                         stiffness: 1,
                                         damping: 0.5,
                                         initialVelocity: 10),
                    value: trackingModel.selection)
                .overlay(
                    VStack {
                        HStack {
                            TabBarSection(selection: $trackingModel.selection, value: 0, text: "Initiation")
                                .transition(.slide)
                                .animation(.default, value: trackingModel.selection)
                                
                            Spacer()
                            TabBarSection(selection: $trackingModel.selection, value: 1, text: "Progression")
                                .transition(.slide)
                                .animation(.default, value: trackingModel.selection)
                            Spacer()
                            TabBarSection(selection: $trackingModel.selection, value: 2, text: "Culmination")
                                .transition(.slide)
                                .animation(.default, value: trackingModel.selection)
                        }
                        ZStack(alignment: trackingModel.rectPosition.alignment) {
                            Rectangle()
                                .foregroundColor(.mintAccent3)
                                .frame(height: 3)
                            
                            Rectangle()
                                .foregroundColor(.mintPrimary)
                                .frame(width: UIScreen.main.bounds.size.width / 3, height: 4)
                        }
                    }
                        .fontDesign(.rounded)
                        .padding(.top, 8)
                        .background(Color.whiteGrayish)
                        
                    
                    
                    , alignment: .top)
                .background(Color.whiteGrayish)
                .clipShape(RoundedShape(radius: 16))
                
            }
            .kerning(-0.8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: trackingModel.selection) { newValue in
                trackingModel.changeRectPosition(value: newValue)
            }
            .onAppear {
                trackingModel.daysCount = coreDataEnv.countHowManyDaySinceStart()
                trackingModel.selection = coreDataEnv.getSectionBasedOnCurrentDay()
            }
            .sheet(isPresented: $trackingModel
                .showingInformationSheet) {
                InformationSheetView()
                        .presentationDetents([.fraction(0.90)])
            }
            .ignoresSafeArea()
        }
    }
}

struct TrackingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingProgressView()
            .environmentObject(CoreDataEnvirontment.singleton)
    }
}
