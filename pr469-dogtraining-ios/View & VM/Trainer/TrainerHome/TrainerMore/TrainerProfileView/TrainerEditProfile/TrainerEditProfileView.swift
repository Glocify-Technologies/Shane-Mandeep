//
//  TrainerEditProfileView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-14.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import PDFKit

struct TrainerEditProfileView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @State var location = Location()
    @State var isLocationSelected = false
    @State var locationLatLOng = CLLocation()
    @State var fullNameValidation = false
    @ObservedObject var vms = ProfileInfoVM()
    @StateObject var vm = TrainerEditProfileVM()
    @State var isSubmitLinkActive: Bool = false
    @State var isServiceSelected: Bool = false
    @State var trainerProfileModel = TrainerProfileModel()
    @State var termsAndConditionImageURL: NSURL?
    @State var documentFileURL: NSURL
    @State private var documentResultURL: [NSURL] = []
    @State private var pickerResultURL: [NSURL] = []
    @State var isTrainingExperience = false
    @State var isDogSportTitle = false
    @State var text:String?
    @State private var documentPickerIsPresented = false
    @State private var documentPdfPickerIsPresented = false
    @State private var termsandConPdfPickerIsPresented = false
    @State var vmss = ProfileInfoVM()
    @State private var pickerResult: [UIImage] = []
    @State var data :Data?
    @State private var documentResult: [UIImage] = []
    @State private var showEditSheet: Bool = false
    @State private var showEditPdfSheet: Bool = false
    @State private var showEditPdfTermsAndConSheet: Bool = false
    @State private var showSheet: Bool = false
    @ObservedObject var imageLoader = ImageLoader()
    @State private var showEditPhotoPicker: Bool = false
    @State private var showEditCertificatePicker: Bool = false
    @State private var showTermsConditionPicker: Bool = false
    @State private var certificateId = ""
    @State private var photosId = ""
    @State private var showEditImagePicker: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showImageSheet: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showDocumentPicker: Bool = false
    @State private var showEditDocumentPicker: Bool = false
    @State private var documentEditPickerIsPresented = false
    @State private var photosEditPickerIsPresented = false
    @State private var showEditPhotosPicker: Bool = false
    @State private var dogSportsTitle: [String] = []
    @State private var imagesBool:Bool = false
    let rows: [GridItem] = [
        
        GridItem(.fixed(140), spacing: 20, alignment: .center)
        
    ]
    @State private var photoPickerIsPresented = false
    @State var termsAndConditionImage: UIImage?
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment:.leading) {
                NavBarWithBackButton(title: "Edit Profile") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: dWidth * 16/375) {
                        //MARK: - FULL NAME
                        InputTextField(title: "Full Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.fullNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.fullNameText)
                            .validate(with: vm.fullNameText, validation: Validators().nonEmptyValidator)
                            .padding(.top, dWidth * 8/375)
                        
                        InputTextField(title: "Email", keyboard: .default, isValidation: Validators().isValidEmailValidator(value: vm.email).isSuccess, isValidationRuntime: $vm.emailValidation, textFiled: $vm.email)
                            .validate(with: vm.email, validation: Validators().isValidEmailValidator)
                        
                        //MARK: - MOBILE
                        MobileNumberTextField(textFiled:$vm.phoneText, mobiletext: "Mobile Number", title: "Please enter here", code: "+64", codeTextField: $vm.phoneCountryCode)
                        
                        InputTextField(title: "Business Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.businessName).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.businessName)
                            .validate(with: vm.businessName, validation: Validators().nonEmptyValidator)
                        
                        //MARK: - LOCATION
                        VStack{
                            NavigationLink (
                                destination: MapKit_Interface(getlocations: $location, locations: $locationLatLOng).navigationBarHidden(true),
                                isActive: $isLocationSelected,
                                label: {
                                    Button(action: {
                                        isLocationSelected.toggle()
                                    }, label: {
                                        DropDownList(title:"Business Location", name: "\(location.address ?? "")" != "" ? "\(location.address ?? "")" : vms.getTrainer?.location ?? "", option: "Change", image: "outline_expand_more_black_18pt_1x")
                                        
                                            .padding(.top, dWidth * 16/375)
                                        
                                    })
                                })
                        
                        }
                        
                        
                        MobileNumberTextField(textFiled: $vm.businessPhoneText, mobiletext: "Business Phone Number", title: "Please enter here", code: "+64", codeTextField: $vm.businessPhoneCountryCode)
                        
                        InputTextField(title: "Website", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.website).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.website)
                            .validate(with: vm.website, validation: Validators().nonEmptyValidator)
                        
                        //MARK: - DropDown Menu
                        ZStack(alignment: .top) {
                            if isServiceSelected {
                                
                                TrainingServiceDropDown(vms:vms,textFiled: $vms.ServicesText, serviceId: $vms.ServicesId, vm: vms)
                                    .offset(y: 30)
//                                    .padding(.bottom, dWidth * 40/375)
                            }
                            Button(action: {
                                isServiceSelected.toggle()
                            }, label: {
                                TrainerEditDropDownList(isServiceSelected: $isServiceSelected, title: "Services Provided", name:vms.ServicesText, nameTwo: "Boarding & Training", image: "outline_expand_more_black_18pt_1x", vms: vms)
                                
                                
                            })
                        }
                    }.padding(.horizontal, dWidth * 16/375)
                        .padding(.bottom, isServiceSelected == true ? dWidth * 40/375 : dWidth * 5/375)
                    // MARK: - Image bar
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text("Images")
                                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                                .foregroundColor(.white)
                                .padding(.horizontal, dWidth * 10/375)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 18) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: dWidth * 10/375)
                                            .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                                            .foregroundColor(Color.black.opacity(0.26))
                                            .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                                        Image("baseline_upload_black_18pt_1x")
                                            .resizable()
                                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                            .clipped()
                                            .foregroundColor(Color("#00C600"))
                                    }
                                    .onTapGesture(count: 1) {
                                        
                                        showImageSheet = true
                                        
                                    }
                                    
                                    .actionSheet(isPresented: $showImageSheet) {
                                        
                                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                            
                                            .default(Text("Photo Library")) {
                                                
                                                self.photoPickerIsPresented = true
                                                
                                                self.sourceType = .photoLibrary
                                                
                                            },
                                            
                                                .default(Text("Camera")) {
                                                    
                                                    self.photoPickerIsPresented = true
                                                    
                                                    self.sourceType = .camera
                                                    
                                                },
                                            
                                                .cancel()
                                            
                                        ])
                                        
                                    }
                                    LazyHGrid(rows: rows) {
                                        if vms.getTrainer?.photos?.count != 0{
                                            ForEach(vms.getTrainer?.photos ?? [], id: \.self) { uiImage in
//                                            ForEach(0 ..< (vms.getTrainer?.photos!.count)!, id: \.self) { index in
                                                VStack(alignment: .leading) {
                                                    ImageView(urlString:uiImage.fileUrl ?? "",images:uiImage.fileImage!)
                                                        .onChange(of: uiImage.fileUrl ?? "") { _ in
                                                            
                                                            vms.updateFiles(photos: URL(string: uiImage.fileUrl ?? ""), fileId: "\(uiImage._id ?? 0)") { success in
                                                                
                                                                print("success \(success)")
                                                                
                                                            }
                                                            
                                                        }
                                                    if imagesBool != true {
                                                    HStack(spacing: 31) {
                                                        Text("Edit")
                                                            .font(.custom("SFProText-Semibold", size: dWidth * 12/375))
                                                            .foregroundColor(Color("#00C600"))
                                                            .onTapGesture(count: 1) {
                                                                self.photosId = "\(uiImage._id ?? 0)"
                                                                self.showEditPhotosPicker = true
                                                                
                                                            }
                                                        
                                                            .actionSheet(isPresented: $showEditPhotosPicker) {
                                                                
                                                                ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                                                    
                                                                    .default(Text("Photo Library")) {
                                                                        
                                                                        self.showEditPhotosPicker = true
                                                                        photosEditPickerIsPresented = true
                                                                        self.sourceType = .photoLibrary
                                                                        
                                                                    },
                                                                    
                                                                        .default(Text("Camera")) {
                                                                            
                                                                            self.showEditPhotosPicker = true
                                                                            photosEditPickerIsPresented = true
                                                                            self.sourceType = .camera
                                                                            
                                                                        },
                                                                    
                                                                        .cancel()
                                                                    
                                                                ])
                                                                
                                                            }
                                                        
                                                        Text("Delete")
                                                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                                                            .foregroundColor(Color("#E84118"))
                                                            .onTapGesture(count: 1) {
                                                                if uiImage._id != 0{
                                                                    vms.deleteFiles(fileId:"\(uiImage._id ?? 0)"){ success in
                                                                        vms.loadTrainerProfile()
                                                                        print("success \(success)")
                                                                        
                                                                    }
                                                                    
                                                                }else{
                                                                    let index = vms.getTrainer?.photos?.firstIndex(of: uiImage)
                                                                    vms.getTrainer?.photos?.remove(at: index ?? 0)
                                                                    let imageIndex = pickerResultURL.firstIndex(of: NSURL(string: uiImage.fileUrl ?? "")!)
                                                                    pickerResultURL.remove(at: imageIndex ?? 0)
                                                                    
                                                                }
                                                                
                                                            }
                                                    }.padding(.horizontal, dWidth * 5/375)
                                                    }
                                                }
                                                
                                            }
                                            
                                            
                                        }
                                        
                                    }
                                    
                                    
                                } //:HStack
                                .padding(.top, dWidth * 70/375)
                            } //:ScrollView
                            .frame(width: dWidth * 350/375, height: dWidth * 24/375)
                        }
                        Spacer()
                    }
                    .padding(.top, isServiceSelected == true ? dWidth * 40/375 : dWidth * 5/375)
                    .padding(.horizontal, dWidth * 16/375)
                    .padding(.bottom, dWidth * 80/375)
                    InputTextField(title: "Job Training Place", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.jobTrainingPlace).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.jobTrainingPlace)
                        .validate(with: vm.jobTrainingPlace, validation: Validators().nonEmptyValidator)
                        .padding(.horizontal, dWidth * 16/375)
                    
                    
                    //MARK: - TrainingExpDropDown
                    ZStack(alignment: .top) {
                        if isTrainingExperience {
                            TrainingExpDropDown(vms:vms,isExpShow:vms.ExperinceText != "" ? true : false,textFiledExp:$vms.ExperinceText, isTrainingExperience: $isTrainingExperience, ExpId: $vms.ExpId)
                                .offset(y: 30)
                            
                        }
                        Button(action: {
                            isTrainingExperience.toggle()
                        }, label: {
                            DropDownList(title: "Training Experience", name:  vms.ExperinceText != "" ?  vms.ExperinceText : "Please select", option: "", image: "outline_expand_more_black_18pt_1x")
                        })
                    }.padding(.top, dWidth * 16/375)
                        .padding(.bottom, isTrainingExperience == true ? dWidth * 40/375 : dWidth * 5/375)
                    ZStack(alignment: .top) {
                        if isDogSportTitle {
                            DogSportDrop(vms:vms,isSportShow:vms.SportText != "" ? true : false,textFiled: $vms.SportText, sportsId: $vms.sportsId, isDogSportTitle: $isDogSportTitle, dogSportsTitle: $dogSportsTitle)
                                .offset(y: 50)
//                                .padding(.bottom, dWidth * 40/375)
                            
                        }
                        Button(action: {
                            isDogSportTitle.toggle()
                        }, label: {
                            DogSportsTitleDropDownList(title: "Dog Sport Titles", name: vms.SportText != "" ?  vms.SportText : "Please select", nameTwo: "" , image: "outline_expand_more_black_18pt_1x", vms: vms,isDogSportTitle:$isDogSportTitle)
                                .padding(dWidth * 16/375)
                            
                            
                        })
                    }
                    .padding(.bottom, isDogSportTitle == true ? dWidth * 90/375 : dWidth * 5/375)
                    //                    .padding(.top, dWidth * 16/375)
                    
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text("Certificates")
                                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                                .foregroundColor(.white)
                                .padding(.horizontal, dWidth * 10/375)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 18) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: dWidth * 10/375)
                                            .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                                            .foregroundColor(Color.black.opacity(0.26))
                                            .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                                        Image("baseline_upload_black_18pt_1x")
                                            .resizable()
                                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                            .clipped()
                                            .foregroundColor(Color("#00C600"))
                                    }
                                    .onTapGesture(count: 1) {
                                        
                                        showDocumentPicker = true
                                        showEditPdfSheet = false
                                    }
                                    
                                    .actionSheet(isPresented: $showDocumentPicker) {
                                        
                                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                            
                                            .default(Text("Photo Library")) {
                                                
                                                self.documentPickerIsPresented = true
                                                
                                                self.sourceType = .photoLibrary
                                                
                                            },
                                            .default(Text("Document Library ")) {
                                                
                                                self.documentPdfPickerIsPresented = true
                                                
//                                                self.sourceType = .
                                                
                                            },
                                            
                                            
                                                .default(Text("Camera")) {
                                                    
                                                    self.documentPickerIsPresented = true
                                                    
                                                    self.sourceType = .camera
                                                    
                                                },
                                            
                                                .cancel()
                                            
                                        ])
                                        
                                    }
                                    LazyHGrid(rows: rows) {
                                        if vms.getTrainer?.certificate?.count != 0{
                                            ForEach(vms.getTrainer?.certificate ?? [], id: \.self) { uiImage in
                                                VStack(alignment: .leading) {
                                                    
                                                    ImageView(urlString: (uiImage.fileUrl)! ,images: (uiImage.fileImage)!)
                                                        .onChange(of: uiImage.fileImage){  _ in
                                                            print("success")
                                                            if let imageId = uiImage.uuid, let url = uiImage.fileUrl {
                                                                vms.updateFiles(fileId: imageId,certificates: URL(string: url)) { success in
                                                                    print("success \(success)")
                                                                }
                                                                
                                                            }
                                                        }
                                                    
                                                    HStack(spacing: 31) {
                                                        Text("Edit")
                                                            .font(.custom("SFProText-Semibold", size: dWidth * 12/375))
                                                            .foregroundColor(Color("#00C600"))
                                                            .onTapGesture(count: 1) {
                                                                self.certificateId = "\(uiImage._id ?? 0)"
                                                                //                                                                    editImage(at:[index])
                                                                showEditCertificatePicker = true
                                                                showEditPdfSheet = true
                                                            }
                                                        
                                                            .actionSheet(isPresented: $showEditCertificatePicker) {
                                                                
                                                                ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                                                    
                                                                    .default(Text("Photo Library")) {
                                                                        
                                                                        
                                                                        self.documentEditPickerIsPresented = true
                                                                        self.showEditCertificatePicker = true
                                                                        self.sourceType = .photoLibrary
                                                                        
                                                                    },
                                                                    .default(Text("Document Library ")) {
                                                                        
                                                                        self.documentPdfPickerIsPresented = true
                                                                        
                        //                                                self.sourceType = .
                                                                        
                                                                    },
                                                                    
                                                                        .default(Text("Camera")) {
                                                                            self.documentEditPickerIsPresented = true
                                                                            self.showEditCertificatePicker = true
                                                                            self.sourceType = .camera
                                                                            
                                                                        },
                                                                    
                                                                        .cancel()
                                                                    
                                                                ])
                                                                
                                                            }
                                                        Text("Delete")
                                                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                                                            .foregroundColor(Color("#E84118"))
                                                            .onTapGesture(count: 1) {
                                                                if uiImage._id != 0{
                                                                    vms.deleteFiles(fileId:"\(uiImage._id ?? 0)"){ success in
                                                                        vms.loadTrainerProfile()
                                                                        print("success \(success)")
                                                                    }
                                                                    
                                                                }else{
                                                                    let index = vms.getTrainer?.certificate?.firstIndex(of: uiImage)
                                                                    vms.getTrainer?.certificate?.remove(at: index ?? 0)
                                                                    let imageIndex = documentResultURL.firstIndex(of: NSURL(string: uiImage.fileUrl ?? "")!)
                                                                    documentResultURL.remove(at: imageIndex ?? 0)
                                                                    
                                                                }
                                                            }
                                                        
                                                        
                                                    }.padding(.horizontal, dWidth * 5/375)
                                                    //                                                    }
                                                }
                                            }
                                        }
                                        
                                        
                                    }
                                    
                                    
                                } //:HStack
                                .padding(.top, dWidth * 70/375)
                            } //:ScrollView
                            .frame(width: dWidth * 350/375, height: dWidth * 24/375)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, dWidth * 16/375)
                    .padding(.bottom, dWidth * 16/375)
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text("Terms & Conditions")
                                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                                .foregroundColor(.white)
                                .padding(.horizontal, dWidth * 10/375)
                            
                            ZStack {
                                VStack(alignment: .leading){
                                    if vms.image == "" && termsAndConditionImage == nil{
                                        ZStack {
                                            RoundedRectangle(cornerRadius: dWidth * 10/375)
                                                .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                                                .foregroundColor(Color.black.opacity(0.26))
                                                .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                                            Image("baseline_upload_black_18pt_1x")
                                                .resizable()
                                                .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                                .clipped()
                                                .foregroundColor(Color("#00C600"))
                                        }
                                            .onTapGesture(count: 1) {
                                                
                                                self.showSheet = true
                                                showEditPdfTermsAndConSheet = false
                                            }

                                            .actionSheet(isPresented: $showSheet) {

                                                ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [

                                                    .default(Text("Photo Library")) {

                                                        self.showImagePicker = true

                                                        self.sourceType = .photoLibrary

                                                    },
                                                    .default(Text("Document Library ")) {
                                                        
                                                        self.termsandConPdfPickerIsPresented = true
                                                        
        //                                                self.sourceType = .
                                                        
                                                    },
                                                    .default(Text("Camera")) {

                                                        self.showImagePicker = true

                                                        self.sourceType = .camera

                                                    },

                                                    .cancel()

                                                ])

                                            }
                                    }else{
                                        if termsAndConditionImage != nil {
                                          
                                            ProfileImageView(urlString:"\(termsAndConditionImageURL!)",images:termsAndConditionImage ?? UIImage(systemName: "photo.fill")!)

                                        }else{
                                           
                                            ProfileImageView(urlString:vms.image,images:termsAndConditionImage ?? UIImage(systemName: "photo.fill")!)
                                        
                                            }
                                        HStack(spacing: 31) {
                                            Text("Edit")
                                                .font(.custom("SFProText-Semibold", size: dWidth * 12/375))
                                                .foregroundColor(Color("#00C600"))
                                                .onTapGesture(count: 1) {

                                                    self.showEditSheet = true
                                                    showEditPdfTermsAndConSheet = true
                                                    print(self.showEditSheet)
                                                }
                                                .actionSheet(isPresented: $showEditSheet) {

                                                    ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [

                                                        .default(Text("Photo Library")) {

                                                            self.showEditImagePicker = true
    //                                                        self.showSheet = true
                                                            self.sourceType = .photoLibrary

                                                        },
                                                        .default(Text("Document Library ")) {
                                                            
                                                            self.termsandConPdfPickerIsPresented = true
                                                            
            //                                                self.sourceType = .
                                                            
                                                        },
                                                            .default(Text("Camera")) {

                                                                self.showEditImagePicker = true
    //                                                            self.showSheet = true
                                                                self.sourceType = .camera

                                                            },

                                                            .cancel()

                                                    ])

                                                }

                                            Text("Delete")
                                                .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                                                .foregroundColor(Color("#E84118"))
                                                .onTapGesture(count: 1) {
                                                    if vms.termsAndConId != "0" && vms.termsAndConId != ""{
                                                        vms.deleteFiles(fileId: vms.termsAndConId){ success in
                                                            vms.loadTrainerProfile()
                                                            vms.termsAndConId =  ""
                                                            vms.image = ""
                                                            termsAndConditionImageURL = nil
                                                            vms.Image = UIImage(systemName: "photo.fill")
                                                            print("success \(success)")
                                                            
                                                        }
                                                    }else{
                                                        vms.termsAndConId =  ""
                                                        vms.image = ""
                                                        termsAndConditionImage = nil
                                                        termsAndConditionImageURL = nil
                                                        vms.Image = UIImage(systemName: "photo.fill")
                                                    }
                                                   
                                                }
                                        }.padding(.horizontal, dWidth * 5/375)
                                    }
                               
                  
                                    
                                }


                            }
                            
                        }
                        Spacer()
                    }.padding(.horizontal, dWidth * 16/375)
                        .padding(.top, dWidth * 70/375)
                    
                    //MARK: - NEXT BUTTON
                    NavigationLink (
                        
                        destination: ProfileInfoTwo(fullName: "", vms: vms, getTrainerProfile: trainerProfileModel, text: text ?? "").navigationBarHidden(true),
                        isActive: $isSubmitLinkActive,
                        label: {
                            
                            ButtonCommon(buttonName: "Save Changes", someAction: {
                                var termsStr = ""
                                var termsAndConditionImageURLFinal = NSURL()
                                if let termsCon = termsAndConditionImageURL{
                                    termsStr = "\(termsCon)"
                                    termsAndConditionImageURLFinal = termsCon
                                }
                                
                                let allServicesArr: NSMutableArray = NSMutableArray()
                                allServicesArr.removeAllObjects()//.removeAllObjects()
                                for i in 0..<(vms.selectServices.count)
                                {
                                    
                                    let jsonDataDict: NSMutableDictionary = NSMutableDictionary()
                                    if !allServicesArr.contains(vms.selectServices[i].service_id){
                                        jsonDataDict.setValue(vms.selectServices[i].price, forKey: "price")
                                        jsonDataDict.setValue(vms.selectServices[i].service_id, forKey: "service_id")
                                        allServicesArr.add(jsonDataDict)
                                    }
                                    
                                }
                                vms.sportsId = ""
                                vms.getTrainer?.sportTitles?.forEach({ sportTitles in
                                    if vms.sportsId == ""{
                                        vms.sportsId = "\(sportTitles._id ?? 0)"
                                    }else{
                                        vms.sportsId = vms.sportsId + "," + "\(sportTitles._id ?? 0)"
                                    }
                                        
                                })
                                var phoneText = vm.phoneText.split(separator: "-").last
                                print(phoneText)
                                let phoneCountryCode = vm.phoneCountryCode + "-" + (phoneText ?? "")
                                var businessText = vm.businessPhoneText.split(separator: "-").last
                                print(businessText)
                                let businessCountryCode = vm.businessPhoneCountryCode  + "-" + (businessText ?? "")
                                print(pickerResultURL)
                                print(documentResultURL)
                                print(documentFileURL)
                                if vms.formValidationsEditProfileInfo(name: vm.fullNameText, email: vm.email, phone: vm.phoneText, businessName: vm.businessName, businessLocation: location.address ?? vms.getTrainer?.location ?? "", businessPhoneNum: vm.businessPhoneText, website: vm.website, SelectService: vms.selectServices, images:pickerResultURL, imagesURLString: (vms.getTrainer?.photos ?? []), jobTraining: vm.jobTrainingPlace, trainingExp: vms.ExperinceText, dogSports: vms.SportText, certificates: documentResultURL, cerificateURLString: vms.getTrainer?.certificate ?? [], terms: termsStr, termsStringURL: vms.Image,countryCode: vm.phoneCountryCode,businessCountryCode: vm.businessPhoneCountryCode){
                                    
                                    vms.setUpTrainersProfileInfo(name: vm.fullNameText, phone: phoneCountryCode , businessName: vm.businessName , location: location.address ?? vms.getTrainer?.location ?? "", latitude: "\(locationLatLOng.coordinate.latitude == 0.0 ? Double(vms.getTrainer?.latitude ?? ""):locationLatLOng.coordinate.latitude)" , longitude: "\(locationLatLOng.coordinate.longitude == 0.0 ? Double(vms.getTrainer?.latitude ?? ""):locationLatLOng.coordinate.longitude)",  businessPhoneNumber: businessCountryCode , wesbite: vm.website , serviceId: allServicesArr, sportTitleId:vms.sportsId , photos: pickerResultURL, trainingPlace: vm.jobTrainingPlace, experienceId: vms.ExpId, termsConditions: termsAndConditionImageURL, certificates: documentResultURL){ success in
                                        if success {
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }

                                }
                                // isSubmitLinkActive.toggle()
                            })
                        }).navigationViewStyle(StackNavigationViewStyle())
                        .alert(isPresented: $vms.isShowAlert) {
                            Alert(title: Text(vms.alertTitle), message: Text(vms.alertMessage), dismissButton: .default(Text("Ok")))}
                        .padding(.top, dWidth * 30/375)
                        .padding(.bottom, dWidth * 30/375)
                }
            } //:VStack
        }.onAppear {
            vm.fullNameText = vms.getTrainer?.users?.name ?? ""
            vm.phoneText = vms.getTrainer?.users?.phone ?? ""
            vm.website = vms.getTrainer?.website ?? ""
            vm.businessName = vms.getTrainer?.businessName ?? ""
            vm.businessPhoneText = vms.getTrainer?.users?.phone ?? ""
            let phoneText = vm.phoneText.split(separator: "-").first
            let phoneTextStr = vm.phoneText.split(separator: "-").last
            vm.phoneText = String(phoneTextStr ?? "")
            vm.phoneCountryCode = String(phoneText ?? "")
            let businessText = vm.businessPhoneText.split(separator: "-").first
            let businessTextStr = vm.businessPhoneText.split(separator: "-").last
            vm.businessPhoneText = String(businessTextStr ?? "")
            vm.businessPhoneCountryCode = String(businessText ?? "")
            vm.email = vms.getTrainer?.users?.email ?? ""
            vm.jobTrainingPlace = vms.getTrainer?.trainingPlace ?? ""
            vms.ExperinceText = vms.getTrainer?.experience?.experience ?? ""
            vms.ExpId = "\(vms.getTrainer?.experience?._id ?? 0)"
            vms.getTrainer?.sportTitles?.forEach({ sportTitles in
                if vms.sportsId == ""{
                    vms.sportsId = "\(sportTitles._id ?? 0)"
                }else{
                    vms.sportsId = (vms.sportsId) +  "," + "\(sportTitles._id ?? 0)"
                }
            })
            for i in 0..<(vms.getTrainer?.file?.count ?? 0){
                // found
                
                if vms.getTrainer?.file?[i].category == "terms and conditions"{
                    
                    if let imageURL = vms.getTrainer?.file?[i].fileUrl {
                        vms.image = imageURL
                        vms.imageLoader.loadData(from: imageURL) { data in
                            vms.Image = UIImage(data: data)
                        }
                        
                    }
                }
                
            }
            vms.loadData()
            vms.loadSportsData()
            vms.loadExperienceData()
            if let servives = vms.getTrainer?.services{
                //                vms.services = servives
                //                var s = vms.services
                //                for i in 0..<s.count {
                //                    s[i].isShow = true
                //                }
                //                vms.services = s
                
                var serviveSelect = [SelectService]()
                for i in 0..<(vms.getTrainer?.services?.count ?? 0){
                    let service = SelectService(service_id: vms.getTrainer?.services?[i]._id, price: 0, name: vms.getTrainer?.services?[i].service)
                    serviveSelect.append(service)
                    
                }
                vms.selectServices = serviveSelect
            }
            if let sportTitles = vms.getTrainer?.sportTitles{
                vms.sportTitle = sportTitles
                
            }
            
            
        }.sheet(isPresented: $photoPickerIsPresented) {
            
            PhotoPicker(pickerResult: $pickerResult, pickerResultURL: $pickerResultURL,
                        
                        isPresented: $photoPickerIsPresented,vms:vms)
            
        }
        .sheet(isPresented: $showImagePicker) {
            
            ImagePicker(image: self.$termsAndConditionImage, imageURL: self.$termsAndConditionImageURL, isShown: self.$showImagePicker, sourceType: self.sourceType)
            
        }
        .sheet(isPresented: $showEditImagePicker) {
            
            EditTermsConditionPicker(image: self.$termsAndConditionImage, imageURL: self.$termsAndConditionImageURL, isShown: self.$showEditImagePicker, vms: vms, sourceType: self.sourceType)
            
        }
        .sheet(isPresented: $documentPickerIsPresented) {
            
            DocumentPicker(documentResult: $documentResult, documentResultURL: $documentResultURL,
                           
                           isPresented: $documentPickerIsPresented, isEditPresented: $showEditCertificatePicker,vms:vms,certificateId:$certificateId)
            
        }
        .sheet(isPresented: $documentPdfPickerIsPresented) {
       
            PdfDocumentPicker(isFrom:$showEditPdfSheet, fileUrl:  $documentFileURL, documentResultURL: $documentResultURL, vms: vms, documentResult: $documentResult,certificateId:$certificateId)
//          PdfDocumentPicker(fileUrl:  $documentFileURL, added: $documentPdfPickerIsPresented)
            
        }
        .sheet(isPresented: $termsandConPdfPickerIsPresented) {
       
            CertificatePdfPicker(isFrom:$showEditPdfTermsAndConSheet, fileUrl:$termsAndConditionImageURL, vms: vms, image: self.$termsAndConditionImage)
//          PdfDocumentPicker(fileUrl:  $documentFileURL, added: $documentPdfPickerIsPresented)
            
        }
        .sheet(isPresented: $documentEditPickerIsPresented){
            EditCertificatePicker(documentResult: $documentResult, documentResultURL: $documentResultURL,
                                  
                                  isPresented: $documentEditPickerIsPresented, isEditPresented: $showEditCertificatePicker,vms:vms,certificateId:$certificateId)
        }
        .sheet(isPresented: $photosEditPickerIsPresented){
            EditPhotosPicker(documentResult: $documentResult, documentResultURL: $documentResultURL,
                                  
                                  isPresented: $photosEditPickerIsPresented, isEditPresented: $showEditPhotosPicker,vms:vms,certificateId:$photosId)
        }
        //ZStack
    }
    
    func editImage(at offsets: IndexSet){
        for offset in offsets {
            self.certificateId = vms.getTrainer?.certificate?[offset].uuid ?? ""

        }
       
    }
    func editPhotos(at offsets: IndexSet){
        for offset in offsets {
            self.photosId = vms.getTrainer?.photos?[offset].uuid ?? ""

        }
       
    }
    
}

struct TrainerEditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerEditProfileView(documentFileURL: NSURL())
    }
}


struct ImagesView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @State var isShow : Bool = false
    var name: String
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    var placeHoleder: String

    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @Binding var textField: String
    @Binding var cvcTxt: String
    let servicesList = [["lesson": "Private Lessons","rate":"$100/per hour"], ["lesson":"Virtual Lessons","rate":"$90/per hour"], ["lesson":"Group Lessons","rate":"$70/per hour"], ["lesson":"Boarding & Training", "rate":"$100/per hour"]]
     var index: Int
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
        }
    }
}
