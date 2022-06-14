//
//  PdfDocumentPicker.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 26/05/22.
//


import Foundation
import SwiftUI
import PDFKit

struct PdfDocumentPicker: UIViewControllerRepresentable {
//    var callback: (Data) -> ()
    @Binding var isFrom :Bool
    @Binding var fileUrl : NSURL
    @Binding var documentResultURL: [NSURL]
    @ObservedObject var vms: ProfileInfoVM
    @Binding var documentResult: [UIImage]
    @Binding var certificateId:String
    func makeCoordinator() -> Coordinator {
        return Coordinator(documentController: self, file: $fileUrl, documentUrl: $documentResultURL, vms: _vms, isFrom: $isFrom, certificateId: $certificateId, documentResult: $documentResult)
    }

    func updateUIViewController(
        _ uiViewController: UIDocumentPickerViewController,
        context: UIViewControllerRepresentableContext<PdfDocumentPicker>) {
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text,.pdf])
        controller.delegate = context.coordinator
        return controller
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var documentController: PdfDocumentPicker
        @Binding var fileUrl : NSURL
        @Binding var documentResultURL: [NSURL]
        @ObservedObject var vms: ProfileInfoVM
        @Binding var isFrom :Bool
        @Binding var certificateId:String
        @Binding var documentResult: [UIImage]
        init(documentController: PdfDocumentPicker,file: Binding<NSURL>,documentUrl:Binding<[NSURL]>,vms:ObservedObject<ProfileInfoVM>,isFrom:Binding<Bool>,certificateId:Binding<String>,documentResult:Binding<[UIImage]>) {
            self.documentController = documentController
            self._documentResultURL = documentUrl
            self._fileUrl = file
            self._vms = vms
            self._isFrom = isFrom
            self._certificateId = certificateId
            self._documentResult = documentResult
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
            self.fileUrl = url as NSURL
            if isFrom == true{
                if let certificate = vms.getTrainer?.certificate {
                    certificate.forEach { file in
                        print("\(file)")
                            if file._id == Int(certificateId){
                                let i = vms.getTrainer?.certificate?.firstIndex(of: file)
                                if let uiImageURL = url as? NSURL {
                                    if let uiImage = pdfThumbnail(url:url){
                                        vms.getTrainer?.certificate?[i ?? 0].fileImage = uiImage
                                        vms.getTrainer?.certificate?[i ?? 0].fileUrl = "\(uiImageURL)"
                                       
                                    }else{
                                        vms.getTrainer?.certificate?[i ?? 0].fileImage = UIImage(systemName: "photo.fill")!
                                        vms.getTrainer?.certificate?[i ?? 0].fileUrl = "\(uiImageURL)"
                                    }
                                
                                    if certificateId != "" {
                                        vms.updateFiles(fileId: certificateId,certificates:uiImageURL as URL) {  success in
                                            self.vms.loadTrainerProfile()
                                                print("success \(success)")
                                            }
                                    }
                                }
           
                            }
                        }
                }
            }else{
                documentResultURL.append(self.fileUrl)
               
                if let uiImageURL = url as? NSURL {
                    if let uiImage = pdfThumbnail(url:url){
                        documentResult.append(uiImage)
                        vms.getTrainer?.certificate?.append(File(uuid: "\(UUID())", key: "", originalFilename: "", publicUrl: "", permalink: "", attachableId: 0, fileUrl: "\(uiImageURL)",fileImage:uiImage, category: "", _id: 0))
                    }else{
                        vms.getTrainer?.certificate?.append(File(uuid: "\(UUID())", key: "", originalFilename: "", publicUrl: "", permalink: "", attachableId: 0, fileUrl: "\(uiImageURL)",fileImage:UIImage(systemName: "photo.fill")!, category: "", _id: 0))
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

