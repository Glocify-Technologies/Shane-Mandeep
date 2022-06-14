//
//  CertificatePdfPicker.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 26/05/22.
//


import Foundation
import SwiftUI
import PDFKit

struct CertificatePdfPicker: UIViewControllerRepresentable {
//    var callback: (Data) -> ()
    @Binding var isFrom :Bool
    @Binding var fileUrl : NSURL?
    @ObservedObject var vms: ProfileInfoVM
    @Binding var image: UIImage?
   
    func makeCoordinator() -> CertificatePdfCoordinator {
        return CertificatePdfCoordinator(documentController: self, file: $fileUrl, vms: _vms, isFrom: $isFrom, image: $image)
    }

    func updateUIViewController(
        _ uiViewController: UIDocumentPickerViewController,
        context: UIViewControllerRepresentableContext<CertificatePdfPicker>) {
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text,.pdf])
        controller.delegate = context.coordinator
        return controller
    }

    class CertificatePdfCoordinator: NSObject, UIDocumentPickerDelegate {
        var documentController: CertificatePdfPicker
        @Binding var fileUrl : NSURL?
        @ObservedObject var vms: ProfileInfoVM
        @Binding var isFrom :Bool
        @Binding var image: UIImage?
       
        init(documentController: CertificatePdfPicker,file: Binding<NSURL?>,vms:ObservedObject<ProfileInfoVM>,isFrom:Binding<Bool>,image:Binding<UIImage?>) {
            self.documentController = documentController
            self._fileUrl = file
            self._vms = vms
            self._isFrom = isFrom
            self._image = image
         
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
            self.fileUrl = url as NSURL
            if isFrom == true{
                if vms.termsAndConId != "0"{
                    if let uiImageURL = url as? NSURL {
                        vms.updateFiles(fileId: vms.termsAndConId, termsConditions:uiImageURL){ success in
                            self.vms.loadTrainerProfile()
                            print("success \(success)")
                            
                        }
                    }
                   
                }
            }else{
                
                if let uiImageURL = url as? NSURL {
                    if let uiImage = pdfThumbnail(url:url){
                        image = uiImage
                    }else{
                        image = UIImage(systemName: "photo.fill")!
                    }
                
                   
                }
            }
           
          
        }
        func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
          guard let data = try? Data(contentsOf: url),
          let page = PDFDocument(data: data)?.page(at: 0) else {
            return nil
          }

          let pageSize = page.bounds(for: .mediaBox)
          let pdfScale = width / pageSize.width

          // Apply if you're displaying the thumbnail on screen
          let scale = UIScreen.main.scale * pdfScale
          let screenSize = CGSize(width: pageSize.width * scale,
                                  height: pageSize.height * scale)

            let image = page.thumbnail(of: screenSize, for: .mediaBox)
            return UIImage(data: image.jpegData(compressionQuality: 0.5)!)
        }
    }
    
    
}

