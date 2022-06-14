import Foundation
import SwiftUI

class PhotoPickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
//    @Binding var images: [UIImage]
//    @Binding var isShown: Bool
    @Binding var pickerResult: [UIImage]
    @Binding var pickerResultURL: [NSURL]
    @Binding var isPresented: Bool
    @ObservedObject var vms: ProfileInfoVM
    init(image: Binding<[UIImage]>, isShown: Binding<Bool>, imageURL: Binding<[NSURL]>,vms: ObservedObject<ProfileInfoVM>) {
        _pickerResult = image
        _isPresented = isShown
        _pickerResultURL = imageURL
        _vms = vms
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickerResult.append(uiImage)
            isPresented = false
            if let uiImageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
                vms.getTrainer?.photos?.append(File(uuid: "\(UUID())", key: "", originalFilename: "", publicUrl: "", permalink: "", attachableId: 0, fileUrl: "\(uiImageURL)",fileImage:uiImage, category: "", _id: 0))
            }
            
        }
        
        if let uiImageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
            pickerResultURL.append(uiImageURL)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isPresented = false
    }
    
}


struct PhotoPicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = PhotoPickerCoordinator
    
    @Binding var pickerResult: [UIImage]
    @Binding var pickerResultURL: [NSURL]
    @Binding var isPresented: Bool
    @ObservedObject var vms: ProfileInfoVM
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
    }
    
    func makeCoordinator() -> PhotoPicker.Coordinator {
        return PhotoPickerCoordinator(image: $pickerResult, isShown: $isPresented, imageURL: $pickerResultURL, vms: _vms)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
        
    }
    
}
