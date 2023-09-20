//
//  DetailTrackingView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 23/07/23.
//

import SwiftUI

struct DetailTrackingView: View {
    @EnvironmentObject private var envObj: GlobalEnvirontment
    @StateObject private var detailTrackingVM: DetailTrackingViewModel
    
    init(challenge: ChallangeEntity) {
        let detailTrackingVM = DetailTrackingViewModel(challange: challenge)
        self._detailTrackingVM = StateObject(wrappedValue: detailTrackingVM)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Day \(detailTrackingVM.challange.day) 🍴")
                .font(.system(.title, weight: .semibold))
                .padding(.horizontal)
                .padding(.bottom, 1)
            Text(detailTrackingVM.challange.date!.getFormattedDate())
                .font(.title3)
                .fontWeight(.medium)
                .padding(.horizontal)
            
            //            SnapCaraousel(index: $detailTrackingVM.scrollIndex, items: detailTrackingVM.cards) { card in
            //
            //            }
            
            //            ScrollView(.horizontal, showsIndicators: false) {
            //                ScrollViewReader { scrollProxy in
            //                    HStack(alignment: .center, spacing: 260) {
            TabView(selection: $detailTrackingVM.scrollIndex) {
                ForEach(0...detailTrackingVM.cardsIsFlipped.count-1, id: \.self) { index in
                    GeometryReader { geometry in
                        HStack {
                            if detailTrackingVM.cardsIsFlipped[index] {
                                GalleryCard(card: detailTrackingVM.cards[index], isFlipped: true)
                                    .rotation3DEffect(
                                        detailTrackingVM.cardsIsFlipped[index] ?
                                        Angle(degrees: 180) : .zero,
                                        axis: (x: 0.0, y: 1.0, z: 0.0))
                            } else {
                                GalleryCard(card: detailTrackingVM.cards[index])
                                
                            }
                        }
                        .frame(width: 269, height: 508, alignment: .center)
                        
                        .padding()
                        .shadow(color: Color.black.opacity(0.08), radius: 12, x: -4, y: 4)
                        .rotation3DEffect(
                            detailTrackingVM.cardsIsFlipped[index] ?
                            Angle(degrees: 180) : .zero,
                            axis: (x: 0.0, y: 1.0, z: 0.0))
                        .animation(.default, value: detailTrackingVM.cardsIsFlipped[index])
                        .onTapGesture {
                            detailTrackingVM.cardsIsFlipped[index].toggle()
                        }
                        .rotation3DEffect(
                            Angle(degrees: Double(geometry
                                .frame(in: .global).minX) - 45) / -20,
                            axis: (x: 0, y: 1.0, z: 0))
                        .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY-50)
                        .tag(index)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 44)
                    .frame(height: 600)
                    
                    
                }
                
            }
            .overlay(alignment: .bottom) {
                HStack {
                    ForEach(0...detailTrackingVM.cardsIsFlipped.count-1, id: \.self) { index in
                        GroupBox {
                            Circle()
                                .fill(detailTrackingVM.scrollIndex == index ?
                                      Color.gray1 : Color.gray2)
                                .frame(width: 8, height: 8)
                        }
                        .backgroundStyle(Color.whiteGrayish)
                        .frame(width: 16, height: 16)
                        .onTapGesture {
                            withAnimation {
                                detailTrackingVM.scrollIndex = index
                            }
                        }
                        
                    }
                }
                
                .offset(y: -40)
            }
            
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
            
            //                    }
            //
            //                }
            //                .padding(.leading, 20)
            //                .padding(.trailing, 300)
            //                .padding(.top, 10)
            //
            //            }
            
        }
        .kerning(-0.8)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    self.envObj.path.removeLast(1)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("My Meals")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
        .fontDesign(.rounded)
        .padding(.top, 34)
        .background(Color.whiteGrayish)
    }
    
    //    func flipCard(index: Int) -> some View {
    //
    //    }
}

struct DetailTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        let challenge = CoreDataEnvirontment.singleton.todayChallenge!
        DetailTrackingView(challenge: challenge)
            .environmentObject(GlobalEnvirontment.singleton)
    }
}
