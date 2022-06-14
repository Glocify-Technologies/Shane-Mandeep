//
//  ImagePicker.swift
//  SwiftUICamera
//
//  Created by Mohammad Azam on 2/10/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI

class EditTermsConditionPickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    @Binding var imageURL: NSURL?
    @ObservedObject var vms: ProfileInfoVM
    
    init(image: Binding<UIImage?>, isShown: Binding<Bool>, imageURL: Binding<NSURL?> , vmss: ObservedObject<ProfileInfoVM> ) {
        _image = image
        _isShown = isShown
        _imageURL = imageURL
        _vms = vmss
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isShown = false
        }
        if let uiImageUrl = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
            imageURL = uiImageUrl
            if vms.termsAndConId != ""{
                vms.updateFiles(fileId: vms.termsAndConId, termsConditions:imageURL){ success in
                    self.vms.loadTrainerProfile()
                    print("success \(success)")
                    
                }
            }
           
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
    
}


struct EditTermsConditionPicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = EditTermsConditionPickerCoordinator
    
    @Binding var image: UIImage?
    @Binding var imageURL: NSURL?
    @Binding var isShown: Bool
    @ObservedObject var vms: ProfileInfoVM
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<EditTermsConditionPicker>) {
    }
    
    func makeCoordinator() -> EditTermsConditionPicker.Coordinator {
        return EditTermsConditionPickerCoordinator(image: $image, isShown: $isShown, imageURL:$imageURL,vmss: _vms)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<EditTermsConditionPicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
        
    }
    
}

