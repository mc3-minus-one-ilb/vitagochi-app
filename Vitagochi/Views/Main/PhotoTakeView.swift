//
//  PhotoTakeView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 19/07/23.
//

import SwiftUI

struct PhotoTakeView: UIViewControllerRepresentable {
    @Binding var showPicker: Bool
    @Binding var imageData: Data
     
    func makeCoordinator() -> Coordinator {
        return PhotoTakeView.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: PhotoTakeView
        
        init(parent: PhotoTakeView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let imageData = (info[.originalImage] as! UIImage).jpegData(compressionQuality: 0.5) {
                parent.imageData = imageData
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.parent.showPicker.toggle()
                } 
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.showPicker.toggle()
        }
    }
}

//struct PhotoTakeView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoTakeView()
//    }
//}
