//
//  DetailTrackingView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 23/07/23.
//

import SwiftUI

struct DetailTrackingView: View {
    @EnvironmentObject var envObj: GlobalEnvirontment
    @StateObject private var detailTrackingVM: DetailTrackingViewModel
    
    init(challenge: ChallangeEntity) {
        let detailTrackingVM = DetailTrackingViewModel(challange: challenge)
        self._detailTrackingVM = StateObject(wrappedValue: detailTrackingVM)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Day \(detailTrackingVM.challange.day) 🎯")
                .font(.system(.largeTitle, weight: .bold))
                .padding(.horizontal)
            Text(detailTrackingVM.challange.date!.getFormattedDate())
                .font(.body)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 260) {
                    ForEach(0..<3) { index in
                        GeometryReader { geometry in
                            HStack {
                                let recordExist = detailTrackingVM.isRecordExist(timeStatus: index)
                                let timePhase = VitaTimePhase(rawValue: Int16(index))!
                                if recordExist.valid {
                                    let vitaMessage = detailTrackingVM
                                        .records[recordExist.index].vitaMessage!
                                    let photo = detailTrackingVM
                                        .photos[recordExist.index]
                                    let time = detailTrackingVM
                                        .records[recordExist.index].time!
                                    if detailTrackingVM.cardsIsFlipped[index] {
                                        GalleryCard(timePhase: timePhase,
                                                    isFlipped: true,
                                                    vitaMessage: vitaMessage)
                                        .rotation3DEffect(
                                            detailTrackingVM.cardsIsFlipped[index] ?
                                            Angle(degrees: 180) : .zero,
                                            axis: (x: 0.0, y: 1.0, z: 0.0))
                                    } else {
                                        GalleryCard(photo: photo,
                                                    timePhase: timePhase,
                                                    time: time,
                                                    isFlipped: false)
                                    }
                                } else {
                                    let cardDate = detailTrackingVM.challange.date!
                                    if detailTrackingVM.cardsIsFlipped[index] {
                                        GalleryCard(timePhase: timePhase,
                                                    isFlipped: true,
                                                    cardDate: cardDate)
                                        .rotation3DEffect(
                                            detailTrackingVM.cardsIsFlipped[index] ?
                                            Angle(degrees: 180) : .zero,
                                            axis: (x: 0.0, y: 1.0, z: 0.0))
                                        
                                    } else {
                                        GalleryCard(timePhase: timePhase,
                                                    isFlipped: false,
                                                    cardDate: cardDate)
                                        
                                    }
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
                            
                        }
                        .padding(.horizontal, 30)
                        
                    }
                    
                }
                .padding(.leading, 20)
                .padding(.trailing, 300)
                .padding(.top, 10)
            }
            
        }
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
                Text("Today's Meal")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
            }
        }
        .background {
            GeometryReader { geo in
                BackgroundArc()
                    .rotation(.degrees(180))
                    .foregroundColor(Color.backgrounCurveColor)
                    .edgesIgnoringSafeArea(.bottom)
                    .padding(.top, geo.size.height * 0.70)
            }
        }
        .fontDesign(.rounded)
        .padding(.top, 24)
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
