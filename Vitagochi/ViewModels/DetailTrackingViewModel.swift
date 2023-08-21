//
//  DetailTrackingViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 19/08/23.
//

import SwiftUI

class DetailTrackingViewModel: ObservableObject {
    @Published var cardsIsFlipped: [Bool] = [false, false, false]
    @Published var waitFlipped: Bool = false
    @Published var challange: ChallangeEntity
    @Published var photos: [UIImage?] = []
    @Published var records: [MealRecordEntity] = []
    
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
