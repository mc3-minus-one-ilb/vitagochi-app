//
//  ChatViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 19/07/23.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var vitaAnswer: VitaMessageAnswer = .exactly
    @Published var showMyOptions: Bool = false
    @Published var myOptionsMessages: [Message] = []
    var photoData: Data?
    
    init(message: Message, photoData: Data? = nil) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.messages.append(message)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.messages.append(Message(id: Date(), text: "It looks good to me!, But are you sure to put some greens or fruit on your meals right ? Not only carbs and proteins 🧐", isMyMessage: false, profilPic: "VitaChatIcon"))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.showMyOptions.toggle()
        }
        
        for answer in VitaMessageAnswer.allCases {
            myOptionsMessages.append(Message(id: Date(), text: answer.myAnswer, isMyMessage: true, profilPic: "", vitaAnswer: answer))
        }
        
        self.photoData = photoData
    }
    
    func writeMessage(id: Date, msg: String, photo: Data?, myMsg: Bool, profilPic: String) {
        messages.append(Message(id: id, text: msg, isMyMessage: myMsg, profilPic: profilPic, photo: photo))
    }
    
    func writeMessage(_ value: Message) {
        messages.append(value)
    }
    
    func savePhoto() -> String? {
        guard let photoData else { return nil }
        do {
            let id = UUID().uuidString
            
            guard let storageURL = FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?.appendingPathComponent(id)
            else { return nil }
            
            print(storageURL)
            
            try photoData.write(to: storageURL)
            
            return id
        } catch {
            print("Failed to save image:", error.localizedDescription)
            return nil
        }
    }
}

//class ChatViewModel: ObservableObject {
//    @Published var messages: [Message] = []
//    
//    func writeMessage(id: Date, msg: String, photo: Data?, myMsg: Bool, profilPic: String) {
//        messages.append(Message(id: id, message: msg, isMyMessage: myMsg, profilPic: profilPic, photo: photo))
//    }
//    
////    @Published var photoData: Data
////    @Published var photo: UIImage
////
////    init(photoData: Data) {
////        self.photoData = photoData
////        if let tempPhoto = UIImage(data: photoData) {
////            self.photo = tempPhoto
////        } else {
////            self.photo = UIImage()
////        }
////    }
//}
