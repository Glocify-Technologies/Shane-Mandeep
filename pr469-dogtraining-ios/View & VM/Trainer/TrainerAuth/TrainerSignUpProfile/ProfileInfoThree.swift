//
//  ProfileInfoThree.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-10.

import SwiftUI

struct ProfileInfoThree: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @ObservedObject var vms: ProfileInfoVM
    @State var isSubmitLinkActive: Bool = false
    @State var isTrainingExperience = false
    @State var isDogSportTitle = false
    @State var fullName: String
    @State var termsAndConditionImage: UIImage?
    @State private var showEditCertificatePicker: Bool = false
    @State var vmss: ProfileInfoVM
    @State private var documentPdfPickerIsPresented = false
    @State private var showSheet: Bool = false
    @State var documentFileURL: NSURL
    @State private var showImagePicker: Bool = false
    @State private var showImageSheet: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showDocumentPicker: Bool = false
    @State private var pickerResult: [UIImage] = []
    @State private var termsandConPdfPickerIsPresented = false
    @State private var documentResult: [UIImage] = []
    @State var termsAndConditionImageURL: NSURL?
    @State private var documentResultURL: [NSURL] = []
    @State private var pickerResultURL: [NSURL] = []
    @State private var dogSportsTitle: [String] = []
    //[UIImage(systemName: "square.and.pencil")!,UIImage(systemName: "square.and.arrow.up")!,UIImage(systemName: "square.and.arrow.down.on.square")!,UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")!]

    @State private var photoPickerIsPresented = false

    @State private var documentPickerIsPresented = false

    

    let rows: [GridItem] = [

        GridItem(.fixed(80), spacing: 20, alignment: .center)

    ]

        
    var getTrainerProfile: TrainerProfileModel
    @StateObject var vm = ProfileInfoVM()
    
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack{
                NavBarWithBackButton(title: "Complete Your Profile") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView(showsIndicators: false) {
                    InputTextField(title: "Job Training Place", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.fullNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.fullNameText)
                        .validate(with: vm.fullNameText, validation: Validators().nonEmptyValidator)
                        .padding(.top, dWidth * 24/375)
                    
                    //MARK: - TrainingExpDropDown
                    ZStack(alignment: .top) {
                        if isTrainingExperience {
                            TrainingExpDropDown(vms:vms,textFiledExp:$vm.ExperinceText, isTrainingExperience: $isTrainingExperience, ExpId: $vm.ExpId)
                                .offset(y: 21)
                        }
                        Button(action: {
                            isTrainingExperience.toggle()
                        }, label: {
                            DropDownList(title: "Training Experience", name:  vm.ExperinceText != "" ?  vm.ExperinceText : "Please select", option: "", image: "outline_expand_more_black_18pt_1x")
                        })
                    }.padding(.top, dWidth * 16/375)
                    
                    //MARK: - Dog Sport Titles Menu
                    ZStack(alignment: .top) {
                        if isDogSportTitle {
                            DogSportDrop(vms:vms,textFiled: $vm.SportText, sportsId: $vm.sportsId, isDogSportTitle: $isDogSportTitle,dogSportsTitle:$dogSportsTitle)
                                .offset(y: 45)
                        }
                        Button(action: {
                            isDogSportTitle.toggle()
                        }, label: {
                            DogSportsTitleProfileDropDownList(dogSportsTitle:$dogSportsTitle, title: "Dog Sport Titles", name: vms.SportText != "" ?  vms.SportText : "Please select", nameTwo: "" , image: "outline_expand_more_black_18pt_1x", vms: vms,isDogSportTitle:$isDogSportTitle)
                                .padding(dWidth * 16/375)
                        })
                    }
//                    .padding(.top,dWidth * 25/375)
                    .padding(.bottom, isDogSportTitle == true ? dWidth * 60/375 :dWidth * 5/375)
                   
                    // MARK: - Certificate bar
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
                                }.onTapGesture(count: 1) {
                                    
                                    //self.showSheet = true

                                    self.showImageSheet = true

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
                                    
                                    ForEach(pickerResult, id: \.self) { uiImage in
                                        ZStack{
                                        Image(uiImage: uiImage)
                                        
                                            .resizable()
                                        
                                            .frame(width: dWidth * 102/375, height: dWidth * 102/375, alignment: .center)
                                        
                                            .cornerRadius(8.0)
                                              
                                            VStack{
                                                HStack{
                                                    Spacer()
                                                    Image("remove")
                                                        .resizable()
                                                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                                        .padding(.trailing,10)
                                                        .padding(.top,10)
                                                        .clipped()
                                                        .foregroundColor(Color("#00C600"))
                                                        .onTapGesture {
                                                            let index = pickerResult.firstIndex(of: uiImage)
                                                            pickerResult.remove(at: index ?? 0)
                                                        }
                                                }
                                                Spacer()
                                            }                                        }
                                        
                                    }
                                    
                                }

                                
                            } //:HStack
                            .padding(.top, dWidth * 70/375)
                        } //:ScrollView
                        .frame(width: dWidth * 350/375, height: dWidth * 32/375)
                    } //:VStack
                    .padding(.top, dWidth * 20/375)
                    
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

                                        ForEach(documentResult, id: \.self) { uiImage in
                                            ZStack{
                                            Image(uiImage: uiImage)
                                            
                                                .resizable()
                                            
                                                .frame(width: dWidth * 102/375, height: dWidth * 102/375, alignment: .center)
                                            
                                                .cornerRadius(8.0)
                                            VStack{
                                                HStack{
                                                    Spacer()
                                                    Image("remove")
                                                        .resizable()
                                                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                                        .padding(.trailing,10)
                                                        .padding(.top,10)
                                                        .clipped()
                                                        .foregroundColor(Color("#00C600"))
                                                        .onTapGesture {
                                                            let index = documentResult.firstIndex(of: uiImage)
                                                            documentResult.remove(at: index ?? 0)
                                                        }
                                                }
                                                Spacer()
                                            }
                                            }
                                            
                                        }
                                        
                                    }
                                    

                                } //:HStack
                                .padding(.top, dWidth * 70/375)
                            } //:ScrollView
                            .frame(width: dWidth * 350/375, height: dWidth * 32/375)
                        }
                    .padding(.top, dWidth * 80/375)
                        
                        
                        
                    VStack(alignment: .leading) {
                        Text("Terms & Conditions")
                            .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(.white)
                            .padding(.horizontal, dWidth * 10/375)
                        
                        ZStack {
                            
                            if termsAndConditionImage != nil {
                                
                                Image(uiImage: termsAndConditionImage ?? UIImage(systemName: "photo.fill")!)
                                
                                    .resizable()
                                
                                    .frame(width: dWidth * 350/375, height: dWidth * 104/375)
                                
                                    .cornerRadius(8.0)
                                VStack{
                                    HStack{
                                        Spacer()
                                        Image("remove")
                                            .resizable()
                                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                            .padding(.trailing,20)
                                            .padding(.top,10)
                                            .clipped()
                                            .foregroundColor(Color("#00C600"))
                                            .onTapGesture {
                                                termsAndConditionImage = nil
                                                termsAndConditionImageURL = nil
                                            }
                                    }
                                    Spacer()
                                }
                                
                            }else{
                                
                                RoundedRectangle(cornerRadius: dWidth * 10/375)
                                
                                    .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                                
                                    .foregroundColor(Color.black.opacity(0.26))
                                
                                    .frame(width: dWidth * 350/375, height: dWidth * 104/375)
                                
                                VStack {
                                    
                                    Image("baseline_upload_black_18pt_1x")
                                    
                                        .resizable()
                                    
                                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                    
                                        .clipped()
                                    
                                        .foregroundColor(Color("#00C600"))
                                    
                                    
                                    
                                    Text("Please upload your terms & conditions")
                                    
                                        .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                                    
                                        .foregroundColor(.white)
                                    
                                    
                                    
                                }
                                
                            }
                        }.onTapGesture(count: 1) {
                            
                            self.showSheet = true

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
                    } //:VStack
                    .padding(.top, dWidth * 110/375)
                    //MARK: - NEXT BUTTON
                    
                    
                    NavigationLink (
                        destination: PaymentMethodView(vms: vms).navigationBarHidden(true),
                        isActive: $isSubmitLinkActive,
                        label: {
                            
                            ButtonCommon(buttonName: "Next", someAction: {
                                print(pickerResultURL)
                                print(documentResultURL)
                                var termsCon = ""
                                if termsAndConditionImageURL != nil{
                                    termsCon = "\(termsAndConditionImageURL!)"
                                }
                                let allServicesArr: NSMutableArray = NSMutableArray()
                                allServicesArr.removeAllObjects()//.removeAllObjects()
                                for i in 0..<(getTrainerProfile.services?.count ?? 0)
                                {

                                    let jsonDataDict: NSMutableDictionary = NSMutableDictionary()

                                    jsonDataDict.setValue(getTrainerProfile.services?[i].price, forKey: "price")
                                    jsonDataDict.setValue(getTrainerProfile.services?[i].service_id, forKey: "service_id")
                                    allServicesArr.add(jsonDataDict)
                                }
//                                var allPhotos : [NSURL] = []
//                                guard let imgData = termsAndConditionImageURL else {
//                                    return
//                                }
//                                allPhotos.append(imgData)
                                
                               
                               
//                                allPhotos.append(imgData)
                                if vm.formValidationsTrainersProfileInfo(trainingPlace: vm.fullNameText,trainingExp: vm.ExperinceText,sportsTitle:vm.SportText,termsCon:termsCon){
                                   
                                    vm.setUpTrainersProfileInfo(name: getTrainerProfile.name ?? "", phone: getTrainerProfile.phone ?? "", businessName: getTrainerProfile.business_name ?? "", location: getTrainerProfile.location ?? "", latitude: "\(getTrainerProfile.lat ?? 0.0)" , longitude: "\(getTrainerProfile.long ?? 0.0)",  businessPhoneNumber: getTrainerProfile.business_phone_number ?? "", wesbite: getTrainerProfile.wesbite ?? "", serviceId: allServicesArr, sportTitleId: vm.sportsId, photos: pickerResultURL, trainingPlace: vm.fullNameText, experienceId: vm.ExpId, termsConditions: termsAndConditionImageURL! , certificates: documentResultURL) { success in
                                        if success {
                                            isSubmitLinkActive.toggle()
                                        }
                                    }
                                }
                            })
                        }).alert(isPresented: $vm.isShowAlert) {
                            Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))}
                        .padding(.top, dWidth * 40/375)
                        .padding(.bottom, dWidth * 30/375)
                } //:ScrollView
                .padding(16)
            } //:VStack
        }.sheet(isPresented: $showImagePicker) {
            
            ImagePicker(image: self.$termsAndConditionImage, imageURL: self.$termsAndConditionImageURL, isShown: self.$showImagePicker, sourceType: self.sourceType)

        }
        .sheet(isPresented: $photoPickerIsPresented) {

            PhotoPicker(pickerResult: $pickerResult, pickerResultURL: $pickerResultURL,

                        isPresented: $photoPickerIsPresented, vms: vms)

                }
        .sheet(isPresented: $termsandConPdfPickerIsPresented) {
       
            CertificatePdfPicker(isFrom:.constant(false), fileUrl:$termsAndConditionImageURL, vms: vms, image: self.$termsAndConditionImage)
            
        }
        .sheet(isPresented: $documentPdfPickerIsPresented) {
       
            PdfDocumentPicker(isFrom:.constant(false), fileUrl:  $documentFileURL, documentResultURL: $documentResultURL, vms: vms, documentResult: $documentResult,certificateId:.constant(""))
//          PdfDocumentPicker(fileUrl:  $documentFileURL, added: $documentPdfPickerIsPresented)
            
        }
        .sheet(isPresented: $documentPickerIsPresented) {

            DocumentPicker(documentResult: $documentResult, documentResultURL: $documentResultURL,

                           isPresented: $documentPickerIsPresented, isEditPresented: $showEditCertificatePicker, vms: vms,certificateId: .constant(""))

        }
//        .onAppear{
//            vm.loadSportsData()
//        } //:ZStack
    }
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

//struct ProfileInfoThree_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileInfoThree(fullName: "", getTrainerProfile: <#TrainerProfileModel#>)
//    }
//}
