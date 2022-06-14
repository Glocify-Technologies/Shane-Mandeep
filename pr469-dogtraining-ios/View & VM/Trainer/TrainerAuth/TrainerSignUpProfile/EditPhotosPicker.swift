
//  DocumentPicker.swift
//  pr469-dogtraining-ios
//
//  Created by Abhishek Mahajan on 11/05/22.
//

import Foundation
import SwiftUI

class EditPhotosPickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @Binding var documentResult: [UIImage]
    @Binding var documentResultURL: [NSURL]
    @Binding var isPresented: Bool
    @ObservedObject var vms: ProfileInfoVM
    @Binding var isEditPresented: Bool
    @Binding var certificateId:String
    
    init(image: Binding<[UIImage]>, isShown: Binding<Bool>, imageURL: Binding<[NSURL]>, vmsModel: ObservedObject<ProfileInfoVM>,isEditPresenteds: Binding<Bool>,certificateId:Binding<String>) {
        _documentResult = image
        _isPresented = isShown
        _documentResultURL = imageURL
        _vms = vmsModel
        _isEditPresented = isEditPresenteds
        _certificateId = certificateId
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if isEditPresented == true{
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let uiImageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                if let certificate = vms.getTrainer?.photos {
                    certificate.forEach { file in
                        print("\(file)")
                            if file._id == Int(certificateId){
                                let i = vms.getTrainer?.photos?.firstIndex(of: file)
                                vms.getTrainer?.photos?[i ?? 0].fileImage = uiImage
                                vms.getTrainer?.photos?[i ?? 0].fileUrl = "\(uiImageURL)"
                                isPresented = false
                                if certificateId != "0"{
                                    vms.updateFiles(photos:uiImageURL, fileId: certificateId) { success in
                                        self.vms.loadTrainerProfile()
                                            print("success \(success)")
                                        }
                                }
                                
                            }
                        }
                }
              }
            }
            isEditPresented = false
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isEditPresented = false
        isPresented = false
    }
}

struct EditPhotosPicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = EditPhotosPickerCoordinator
    
    @Binding var documentResult: [UIImage]
    @Binding var documentResultURL: [NSURL]
    @Binding var isPresented: Bool
    @Binding var isEditPresented: Bool
    @ObservedObject var vms: ProfileInfoVM
    @Binding var certificateId:String
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<EditPhotosPicker>) {
    }
    
    func makeCoordinator() -> EditPhotosPicker.Coordinator {
        return EditPhotosPickerCoordinator(image: $documentResult, isShown: $isPresented, imageURL: $documentResultURL, vmsModel: _vms, isEditPresenteds: $isEditPresented, certificateId: $certificateId)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
}
