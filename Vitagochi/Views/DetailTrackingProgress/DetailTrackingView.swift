//
//  DetailTrackingView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 23/07/23.
//

import SwiftUI

struct DetailTrackingView: View {
    @State private var flipped: [Bool] = [false, false, false]
    @State private var waitFlipped: Bool = false
    var challange: ChallangeEntity
    var photos: [UIImage?] = []
    var records: [MealRecordEntity] = []
    
    init(challange: ChallangeEntity) {
        self.challange =  challange
        if let mealRecords = challange.records?.allObjects as? [MealRecordEntity] {
            for record in mealRecords.sorted(by: {$0.timeStatus < $1.timeStatus}) {
                self.photos.append(UIImage(contentsOfFile: getImagePath(name: record.photo ?? "") ?? ""))
                self.records.append(record)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Day \(challange.day) 🎯")
                .font(.system(.largeTitle, weight: .bold))
                .padding(.horizontal)
            Text(challange.date!.getFormattedDate())
                .font(.body)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 260) {
                    ForEach(0..<3) { index in
                        GeometryReader { geometry in
                            HStack{
                                let recordExist = isRecordExist(timeStatus: index)
                                if recordExist.valid {
                                    if flipped[index] {
                                        GalleryCard(timePhase: VitachiTimePhase(rawValue: Int16(index))! ,isFlipped: true)
                                            .rotation3DEffect(flipped[index]  ? Angle(degrees: 180) : .zero, axis: (x: 0.0 , y: 1.0, z: 0.0))
                                    } else {
                                        GalleryCard(photo: photos[recordExist.index], timePhase: VitachiTimePhase(rawValue: Int16(index))!, time: records[isRecordExist(timeStatus: index).1].time! ,isFlipped: false)
                                        
                                    }
                                } else {
                                    if flipped[index] {
                                        GalleryCard(timePhase: VitachiTimePhase(rawValue: Int16(index))! ,isFlipped: true)
                                            .rotation3DEffect(flipped[index]  ? Angle(degrees: 180) : .zero, axis: (x: 0.0 , y: 1.0, z: 0.0))
                                        
                                    } else {
                                        
                                        GalleryCard(timePhase: VitachiTimePhase(rawValue: Int16(index))! ,isFlipped: false)
                                        
                                    }
                                }
                            }
                            .frame(width: 269,height: 508, alignment: .center)
                            .padding()
                            .shadow(color: Color.black.opacity(0.2),radius: 10, x: 0, y: 0)
                            .rotation3DEffect(flipped[index] ? Angle(degrees: 180) : .zero, axis: (x: 0.0, y: 1.0, z: 0.0))
                            .animation(.default, value: flipped[index])
                            .onTapGesture {
                                flipped[index].toggle()
                            }
                            .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) - 45) / -20, axis: (x: 0, y: 1.0, z: 0))
                            
                        }
                        .padding(.horizontal, 30)
                        
                    }
                    
                }
                .padding(.leading, 20)
                .padding(.trailing, 300)
                .padding(.top, 10)
            }
            
        }
        .navigationTitle("Today's Meal")
        .background {
            GeometryReader { geo in
                BackgroundArc()
                    .rotation(.degrees(180))
                    .foregroundColor(Color.backgrounCurveColor)
                    .edgesIgnoringSafeArea(.bottom)
                    .padding(.top, geo.size.height * 0.70)
            }
        }
        .padding(.top, 50)
    }
    
    func isRecordExist(timeStatus: Int) -> (valid:Bool,index:Int) {
        var index = 0
        for record in records {
            if record.timeStatus == Int16(timeStatus) {
                return (true, index)
            }
            index += 1
        }
        return (false, 0)
    }
    
    func getImagePath(name: String) -> String? {
        guard let imagePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(name).path,
              FileManager.default.fileExists(atPath: imagePath) else {
            return nil
        }
        return imagePath
    }
}

struct DetailTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTrackingView(challange: CoreDataEnvirontment.singleton.todayChallange!)
    }
}
