//
//  DetailTrackingViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 19/08/23.
//

import SwiftUI

struct Card: Identifiable {
    let id: String = UUID().uuidString
    let phase: VitaTimePhase
    let message: String
    let mainPhoto: UIImage?
    let time: Date?
}

class DetailTrackingViewModel: ObservableObject {
    @Published var cardsIsFlipped: [Bool] = [false, false, false]
    @Published var waitFlipped: Bool = false
    @Published var challange: ChallangeEntity
    @Published var photos: [UIImage?] = []
    @Published var records: [MealRecordEntity] = []
    @Published var cards: [Card] = []
    @Published var scrollIndex: Int = 0
    
    init(challange: ChallangeEntity) {
        self.challange =  challange
        let nilPath = ""
        if let mealRecords = challange.records?.allObjects as? [MealRecordEntity] {
            for record in mealRecords.sorted(by: {$0.timeStatus < $1.timeStatus}) {
                self.photos.append(
                    UIImage(contentsOfFile: getImagePath(name: record.photo ?? nilPath) ?? nilPath)
                )
                self.records.append(record)
            }
        }
        for index in 0...3 {
            let recordExist = isRecordExist(timeStatus: index)
            let phase = VitaTimePhase.init(rawValue: Int16(index))!
            var message = phase.mealQuote
            
            if recordExist.valid {
                let mealStatus = VitaChatAnswer.init(rawValue: records[recordExist.index].mealStatus)!
                message = getMessageBaseOnMeal(mealsStatus: mealStatus)
            }
            
            let mainPhoto: UIImage? = recordExist.valid ? photos[recordExist.index] : nil
            let time = recordExist.valid ? records[recordExist.index].time : nil
            let card =  Card(phase: phase,
                             message: message,
                             mainPhoto: mainPhoto,
                             time: time)
            cards.append(card)
        }
    }
    
    func isRecordExist(timeStatus: Int) -> (valid: Bool, index: Int) {
        var index = 0
        for record in records {
            if record.timeStatus == Int16(timeStatus) {
                return (true, index)
            }
            index += 1
        }
        return (false, 0)
    }
    
    func getMessageBaseOnMeal(mealsStatus: VitaChatAnswer) -> String {
        switch mealsStatus {
        case.exactly:
            return "A fancy time to have a full\nmeal including veggies and\nfruit ✨"
        case.greensOnly:
            return "Many people believe that\neating greens give a ton of\nbenefit! 😌"
        case.fruitsOnly:
            return "Fruits is a perfect combo if it's\neaten after having a full meal\n😌"
        case.sadlyNo:
            return "Another day of leaving the\nveggies and fruits ... 😮‍💨"
        }
    }
    
    func getImagePath(name: String) -> String? {
        guard let imagePath =  FileManager
            .default.urls(for: .documentDirectory,
                          in: .userDomainMask)
                .first?.appendingPathComponent(name).path,
              FileManager.default.fileExists(atPath: imagePath) else {
            return nil
        }
        return imagePath
    }
}
