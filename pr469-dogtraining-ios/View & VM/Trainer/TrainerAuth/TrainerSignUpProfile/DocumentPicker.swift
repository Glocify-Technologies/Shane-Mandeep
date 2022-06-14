//
//  DocumentPicker.swift
//  pr469-dogtraining-ios
//
//  Created by Abhishek Mahajan on 11/05/22.
//

import Foundation
import SwiftUI

class DocumentPickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
//    @Binding var images: [UIImage]
//    @Binding var isShown: Bool
//    @Binding var pickerResult: [UIImage]
//    @Binding var pickerResultURL: [NSURL]
//    @Binding var isPresented: Bool
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
            if let uiImageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
                if let certificate = vms.getTrainer?.certificate {
                    certificate.forEach { file in
                        print("\(file)")
                       if file.uuid == certificateId{
                           let collection = File(uuid:file.uuid, key: file.key, originalFilename: file.originalFilename, publicUrl: file.publicUrl, permalink: file.permalink, attachableId: file.attachableId, fileUrl: "\(uiImageURL)",fileImage:uiImage, category: file.category, _id: file._id ?? 0 )
                           let i = vms.getTrainer?.certificate?.firstIndex(of: file)
                           vms.getTrainer?.certificate?.remove(at: i ?? 0)
                           vms.getTrainer?.certificate?.append(collection)
                       }
                    }

                }
              }
            }
            isEditPresented = false
        }else{
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            documentResult.append(uiImage)
            isPresented = false
            if let uiImageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
                vms.getTrainer?.certificate?.append(File(uuid: "\(UUID())", key: "", originalFilename: "", publicUrl: "", permalink: "", attachableId: 0, fileUrl: "\(uiImageURL)",fileImage:uiImage, category: "", _id: 0))
            }
            
        }
        
        if let uiImageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
            documentResultURL.append(uiImageURL)
        }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isPresented = false
    }
//    func processSelected(image:[UIImagePickerController.InfoKey : Any],completion:@escaping(_ url:NSURL?)->()){
//        if let uiImageURL = image[UIImagePickerController.InfoKey.imageURL] as? NSURL {
//            let imageName = uiImageURL.lastPathComponent!
//            let docDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//            let localPath = docDirectory?.appending(imageName)
//            if let img = image[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                let data = img.jpegData(compressionQuality: 0.5)
//                do {
//                    try? data?.write(to: URL(string: localPath!)!)
//                    //                    let imageDt = NSData(contentsOfFile: localPath!)
//    //                let photoURL =
//                    completion(NSURL.init(fileURLWithPath: localPath!))
//    //                return URL.init(fileURLWithPath: localPath!)
//                    //                    documentResultURL.append(photoURL)
//                }catch let err {
//                    print("could not process image properly.")
//                }
//            }
//        }
//    }
}


struct DocumentPicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = DocumentPickerCoordinator
    
    @Binding var documentResult: [UIImage]
    @Binding var documentResultURL: [NSURL]
    @Binding var isPresented: Bool
    @Binding var isEditPresented: Bool
    @ObservedObject var vms: ProfileInfoVM
    @Binding var certificateId:String
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }
    
    func makeCoordinator() -> DocumentPicker.Coordinator {
        return DocumentPickerCoordinator(image: $documentResult, isShown: $isPresented, imageURL: $documentResultURL, vmsModel: _vms, isEditPresenteds: $isEditPresented, certificateId: $certificateId)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
}
