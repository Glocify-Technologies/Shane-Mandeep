//
//  TrainerProfileView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-10.
//

import SwiftUI
import SDWebImageSwiftUI
import PDFKit

struct TrainerProfileView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    
    @State var isCompleteEditLinkActive: Bool = false
    @State var isCompletePasswordLinkActive: Bool = false
    @State var isTrainerEditServiceViewLinkActive: Bool = false
    @State var fullNameValidation = false
    @StateObject var vm = AddPetProfileVM()
    @State var isSubmitLinkActive: Bool = false
    @StateObject var vms: ProfileInfoVM
    //    var urlString: String
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    let rowsServices: [GridItem] = [
        GridItem(.fixed(32), spacing: 20, alignment: .center)
    ]
    @State var profileImageURL: NSURL?
    
    @State private var showSheet: Bool = false
    
    @State private var showImagePicker: Bool = false
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State var image = UIImage(systemName: "person.fill")!
    @State private var profileImageurl: String = ""
    let rowsPhotos: [GridItem] = [

        GridItem(.fixed(120), spacing: 20, alignment: .center)

    ]
    
    let rowsCertificates: [GridItem] = [

        GridItem(.fixed(80), spacing: 20, alignment: .center)

    ]
    var body: some View { 
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                NavBarWithBackButton(title: "Profile") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView {
                    ZStack(alignment: .bottomTrailing) {
                        

                        ProfileImageViews(urlString: profileImageurl != "" ? profileImageurl : (vms.getTrainer?.users?.avatarUrl ?? ""),images: profileImage ?? UIImage(systemName: "person.fill")!)
                        .onChange(of: profileImage) { _ in
                            
                            vms.setUpProfileTrainer(image: profileImageURL! as URL) { success,data  in
                                profileImageurl = data?.payload?.avatarUrl ?? ""
                                print("success \(success)")
                                
                            }
                            
                        }
                        .padding(.top, 10)
                        Button {
                            
                            self.showSheet = true
                            
                        } label: {
                            
                            Image("outline_edit_black_18pt_1x")
                            
                                .resizable()
                            
                                .frame(width: dWidth * 25/375, height: dHeight * 25/875, alignment: .center)
                                .foregroundColor(Color.black)
//                                .foregroundColor(Color("#00C600"))
                                .background(
                                    ZStack{
                                        Color("#00C600")
                                            .edgesIgnoringSafeArea(.all)
                                            
                                    } .frame(width: dWidth * 38/375, height: dHeight * 38/875, alignment: .center)
                                        .cornerRadius(5)
                                  
                                )
                                .offset(x: dWidth * 15/375, y: dWidth * 10/375)
                            
                        }
                        .padding(.top,-8)
                        .actionSheet(isPresented: $showSheet) {
                            
                            ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                
                                .default(Text("Photo Library")) {
                                    
                                    self.showImagePicker = true
                                    
                                    self.sourceType = .photoLibrary
                                    
                                },
                                
                                    .default(Text("Camera")) {
                                        
                                        self.showImagePicker = true
                                        
                                        self.sourceType = .camera
                                        
                                    },
                                
                                    .cancel()
                                
                            ])
                            
                        }
                    }
                    
                    Text(vms.getTrainer?.users?.name ?? "")
                        .font(.custom("SFProText-Bold", size: dWidth * 20/375))
                        .foregroundColor(.white)
                        .padding(.top, dWidth * 20/375)
                    
                    HStack {
                        Image("baseline_call_black_18pt_1x")
                            .resizable()
                            .frame(width: dWidth * 18/375, height: dHeight * 18/875, alignment: .center)
                            .foregroundColor(Color("#00C600"))
                        
                        Text(vms.getTrainer?.users?.phone ?? "")
                            .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(.white)
                    } //:HStack
                    HStack {
                        Image("baseline_email_black_12pt_1x")
                            .resizable()
                            .frame(width: dWidth * 18/375, height: dHeight * 18/875, alignment: .center)
                            .foregroundColor(Color("#00C600"))
                        Text(vms.getTrainer?.users?.email ?? "")
                            .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(.white)
                    }   //:HStack
                    VStack(alignment: .leading, spacing: dWidth * 10/375) {
                        VStack(alignment: .leading, spacing: dWidth * 10/375) {
                            Text("Business Name")
                                .font(Font.custom("SFProText-Regular", size: dWidth * 12/375))
                                .foregroundColor(Color("#848484"))
                            Text(vms.getTrainer?.businessName ?? "")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                                .foregroundColor(Color.white)
                                .padding(.bottom, dWidth * 10/375)
                            
                            Text("Business Location")
                                .font(Font.custom("SFProText-Regular", size: dWidth * 12/375))
                                .foregroundColor(Color("#848484"))
                            Text(vms.getTrainer?.location ?? "")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                                .foregroundColor(Color.white)
                                .padding(.bottom, dWidth * 10/375)
                            
                            Text("Business Phone Number")
                                .font(Font.custom("SFProText-Regular", size: dWidth * 12/375))
                                .foregroundColor(Color("#848484"))
                            Text(vms.getTrainer?.users?.phone ?? "")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                                .foregroundColor(Color.white)
                                .padding(.bottom, dWidth * 10/375)
                            
                            Text("Website")
                                .font(Font.custom("SFProText-Regular", size: dWidth * 12/375))
                                .foregroundColor(Color("#848484"))
                            Text(vms.getTrainer?.website ?? "")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                                .foregroundColor(Color.white)
                                .padding(.bottom, dWidth * 10/375)
                            
                            Text("Services Provided")
                                .font(Font.custom("SFProText-Regular", size: dWidth * 12/375))
                                .foregroundColor(Color("#848484"))
//                            ScrollView(.horizontal) {
//                                LazyHGrid(rows: rowsServices) {
//                                    ForEach(vms.getTrainer?.services ?? [Service(_id: nil, service: nil, createdAt: nil, updatedAt: nil, pivot: Pivot(service_id: nil, trainer_id: nil, price: nil))]) { service in
//                                        Text(service.service != "" ? ("\(service.service ?? "")" + " - " + "$\(service.pivot?.price ?? "")per/hr") : "")
//
//                                            .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
//
//                                            .foregroundColor(Color.white)
//
//                                            .padding(.horizontal, dWidth * 10/375)
//
//                                            .padding(.vertical, dWidth * 2/375)
//
//                                            .background(
//
//                                                RoundedRectangle(cornerRadius: dWidth * 10/375)
//
//                                                    .stroke(Color("#7E7E7E"), lineWidth: 0.5)
//
//                                                    .foregroundColor(Color("#191919").opacity(0.26))
//
//                                            )
//
//                                            .padding(.bottom, dWidth * 10/375)
//
//                                    }
//
//                                }
//
//                            }
                            SereviceShowView(services: vms.getTrainer?.services ?? [Service(_id: nil, service: nil, createdAt: nil, updatedAt: nil, pivot: Pivot(service_id: nil, trainer_id: nil, price: nil))])
                        .padding(.bottom, dWidth * 10/375)

                        }
                        
                        VStack(alignment: .leading) {
                            Text("Images")
                                .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                                .foregroundColor(.white)
                            CertificateShowView(certificate: vms.getTrainer?.photos)
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 18) {
//                                    LazyHGrid(rows: rowsPhotos) {
//                                        if let arr = vms.getTrainer?.photos{
//                                            ForEach(arr, id: \.self) { uiImage in
//                                                autoreleasepool{
//                                                ImageView(urlString:uiImage.fileUrl ?? "" )
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
                        }.padding(.bottom, dWidth * 10/375)
                        
                        
                        VStack(alignment: .leading) {
                            Text("Job Training Place")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
                            Text(vms.getTrainer?.trainingPlace ?? "")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                                .foregroundColor(Color.white)
                                .padding(.bottom, dWidth * 10/375)
                            
                            Text("Training Experience")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
                            Text(vms.getTrainer?.experience?.experience ?? "")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                                .foregroundColor(Color.white)
                                .padding(.bottom, dWidth * 10/375)
                            
                            Text("Dog Sport Titles")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
                            Text(vms.SportText )
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                                .foregroundColor(Color.white)
                                .padding(.bottom, dWidth * 10/375)
                            
                            Text("Certificates")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 18) {
//                                    LazyHGrid(rows: rowsPhotos) {
//                                        if let arr = vms.getTrainer?.certificate{
//                                            ForEach(arr, id: \.self) {  uiImage in
//                                                ImageView(urlString:uiImage.fileUrl ?? "",images: uiImage.fileImage ?? UIImage(systemName: "person.fill")!)
//
//                                            }
//                                        }
//                                    }
//
//                                }
//                            }
                            
                            CertificateShowView(certificate: vms.getTrainer?.certificate)
                            
                            Text("Terms & Conditions")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
                            ProfileImageView(urlString:vms.image,images:(vms.Image ?? UIImage(systemName: "photo.fill"))!)

                        }
                    } //:VStack
                    .padding(dWidth * 16/375)
                    .background(
                        RoundedRectangle(cornerRadius: dWidth * 10/375)
                            .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                            .foregroundColor(Color("#191919").opacity(0.26))
                    )
                    .padding(.horizontal, dWidth * 16/375)
                    NavigationLink (
                        destination: TrainerEditServiceView(fullName: "", vms: vms).navigationBarHidden(true),
                        isActive: $isCompleteEditLinkActive,
                        label: {
                            ButtonCommon(buttonName: "Edit Services", someAction: {
                                isCompleteEditLinkActive.toggle()
                            })
                        }).navigationViewStyle(.stack)
                        .padding(.bottom, dWidth * 16/375)
                        .padding(.top, dWidth * 16/375)
                    NavigationLink (
                        destination: TrainerEditProfileView(vms:vms, documentFileURL: NSURL()).navigationBarHidden(true),
                        isActive: $isTrainerEditServiceViewLinkActive,
                        label: {
                            ButtonCommon(buttonName: "Edit Profile", someAction: {
                                isTrainerEditServiceViewLinkActive.toggle()
                            })
                        })
                        .padding(.bottom, dWidth * 16/375)
                    
                    NavigationLink (
                        destination: ChangePasswordView().navigationBarHidden(true),
                        isActive: $isCompletePasswordLinkActive,
                        label: {
                            ButtonCommonBlack(buttonName: "Change Password", someAction: {
                                isCompletePasswordLinkActive.toggle()
                            }, color: "#FFFFFF")
                        }).padding(.bottom, dWidth * 16/375)
                }
            }
        }
        .onAppear {
            SDImageCache.shared.clearMemory()
            SDImageCache.shared.clearDisk(onCompletion: nil)
            vms.loadTrainerProfile()
           
        }
        .sheet(isPresented: $showImagePicker) {
            
            ImagePicker(image: self.$profileImage, imageURL: $profileImageURL, isShown: self.$showImagePicker, sourceType: self.sourceType)

        }
        //:ZStack
    }
  
   

}

struct TrainerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerProfileView(vms: ProfileInfoVM())
    }
}


struct CertificateShowView: View {
    let rowsPhotos: [GridItem] = [

        GridItem(.fixed(120), spacing: 20, alignment: .center)

    ]
    var certificate: [File]?
    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    LazyHGrid(rows: rowsPhotos) {
                        if let arr = certificate{
                            ForEach(arr) {  uiImage in
                                autoreleasepool {
                                ImageView(urlString:uiImage.fileUrl ?? "",images: uiImage.fileImage ?? UIImage(systemName: "person.fill")!)
                                }
                            }
                        }
                    }

                }
            }
        }
    }
}
struct SereviceShowView: View {

    private let dWidth = UIScreen.main.bounds.width
    let rowsServices: [GridItem] = [
        GridItem(.fixed(32), spacing: 20, alignment: .center)
    ]
    var services: [Service]?
    var body: some View {
        ZStack() {
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rowsServices) {
                    ForEach(services ?? [Service(_id: nil, service: nil, createdAt: nil, updatedAt: nil, pivot: Pivot(service_id: nil, trainer_id: nil, price: nil))]) { service in
                        Text(service.service != "" ? ("\(service.service ?? "")" + " - " + "$\(service.pivot?.price ?? "")per/hr") : "")
                        
                            .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                        
                            .foregroundColor(Color.white)
                        
                            .padding(.horizontal, dWidth * 10/375)
                        
                            .padding(.vertical, dWidth * 2/375)
                        
                            .background(
                                
                                RoundedRectangle(cornerRadius: dWidth * 10/375)
                                
                                    .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                                
                                    .foregroundColor(Color("#191919").opacity(0.26))
                                
                            )
                        
                            .padding(.bottom, dWidth * 10/375)
                        
                    }
                    
                }
                
            }
        }

    }
}

struct ImageView: View {
    var urlString: String
    @State var images = UIImage(systemName: "person.fill")!
    private let dWidth = UIScreen.main.bounds.width
    var body: some View {
        ZStack() {
            
            ZStack {
                RoundedRectangle(cornerRadius: dWidth * 10/375)
                    .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                    .foregroundColor(Color.black.opacity(0.26))
                    .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                    WebImage(url: URL(string:urlString ))
                    .resizable()
                    .placeholder(Image(uiImage: images).resizable())
                    .indicator(.activity) // Activity Indicator
                    .scaledToFill()
                    .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                    .clipped()
                    .foregroundColor(Color("#00C600"))
                    .cornerRadius(dWidth * 10/375)
            }
        }

    }
}
struct ProfileImageView: View {
    var urlString: String
    @State var images = UIImage(systemName: "person.fill")!
    private let dWidth = UIScreen.main.bounds.width
    var body: some View {
        ZStack() {
            
            ZStack {
                RoundedRectangle(cornerRadius: dWidth * 10/375)
                    .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                    .foregroundColor(Color.black.opacity(0.26))
                    .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                    WebImage(url: URL(string:urlString ))
                    .pausable(false)
                    .purgeable(true)
                    .resizable()
                    .placeholder(Image(uiImage: images).resizable())
                    .indicator(.activity) // Activity Indicator
                    .scaledToFill()
                    .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                    .clipped()
                    .foregroundColor(Color("#00C600"))
                    .cornerRadius(dWidth * 10/375)
            }
        }

    }
}

struct ProfileImageViews: View {
    var urlString: String
    @State var images = UIImage(systemName: "person.fill")!
    private let dWidth = UIScreen.main.bounds.width
    var body: some View {
//        ZStack() {
            
            ZStack {
                RoundedRectangle(cornerRadius: dWidth * 10/375)
                    .stroke(Color("#FFFFFF"), lineWidth: dWidth * 5.5/375)
                    .foregroundColor(Color.black.opacity(0.26))
                    .frame(width: dWidth * 150/375, height: dWidth * 150/375)

                WebImage(url: URL(string:urlString ))
                    .pausable(false)
                    .purgeable(true)
                   .resizable() 
                   .placeholder(Image(uiImage: images).resizable()) // Placeholder Image
                   .indicator(.activity) // Activity Indicator
                   .scaledToFill()
                   .frame(width: dWidth * 150/375, height: dWidth * 150/375)
                   .clipped()
                   .cornerRadius(dWidth * 10/375)
            }
//        }
//        .onAppear {
//            let name = urlString
//            if name.contains(".pdf") {
//                images = pdfThumbnail(url: URL(string: urlString)!) ?? UIImage(systemName: "person.fill")!
//            }
//        }
    }
//    func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
//      guard let data = try? Data(contentsOf: url),
//      let page = PDFDocument(data: data)?.page(at: 0) else {
//        return nil
//      }
//
//      let pageSize = page.bounds(for: .mediaBox)
//      let pdfScale = width / pageSize.width
//
//      // Apply if you're displaying the thumbnail on screen
//      let scale = UIScreen.main.scale * pdfScale
//      let screenSize = CGSize(width: pageSize.width * scale,
//                              height: pageSize.height * scale)
//
//        let image = page.thumbnail(of: screenSize, for: .mediaBox)
//        return UIImage(data: image.jpegData(compressionQuality: 0.5)!)
//    }
}
struct TermsImageView: View {
    var url: String
    @State var image = UIImage(systemName: "person.fill")!
    private let dWidth = UIScreen.main.bounds.width
    var body: some View {
        ZStack() {
            
            ZStack {
                RoundedRectangle(cornerRadius: dWidth * 10/375)
                    .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                    .foregroundColor(Color.black.opacity(0.26))
                    .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                    WebImage(url: URL(string:url ))
                    .pausable(false)
                    .purgeable(true)
                    .resizable()
                    .placeholder(Image(uiImage: image).resizable())
                    .indicator(.activity) // Activity Indicator
                    .scaledToFill()
                    .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                    .clipped()
                    .cornerRadius(dWidth * 10/375)
                    .foregroundColor(Color("#00C600"))
            }
        }

    }
}
