//
//  ProfileInfoOne.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/17/21.
//

import SwiftUI
import CoreLocation

struct ProfileInfoOne: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @State var text: String
    @State var fullName: String
    @State var fullNameValidation = false
    @StateObject var vm = ProfileInfoVM()
    @State var isSubmitLinkActive: Bool = false
    @State var isServiceSelected: Bool = false
    @State var location = Location()
    @State var isLocationSelected = false
    @State var locationLatLOng = CLLocation()
    @State var trainerProfileModel = TrainerProfileModel()
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavBarWithBackButton(title: "Complete Your Profile") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView(showsIndicators: false) {
                    //MARK: - FULL NAME
                    InputTextField(title: "Full  Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.fullNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.fullNameText)
                        .validate(with: vm.fullNameText, validation: Validators().nonEmptyValidator)
                        .padding(.top, dWidth * 24/375)
                    
                    //MARK: - MOBILE
                    MobileNumberTextField(textFiled:$vm.phoneText, mobiletext: "Mobile Number", title: "Please enter here", code: "+64",codeTextField: $vm.phoneCountryCode)
                        .padding(.top, dWidth * 16/375)
                    
                    InputTextField(title: "Business Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.businessNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.businessNameText)
                        .validate(with: vm.businessNameText, validation: Validators().nonEmptyValidator)
                        .padding(.top, dWidth * 16/375)
                    
                    //MARK: - LOCATION
//                    DropDownList(title: "Business Location", name: "Melbourne", option: "Change", image: "outline_chevron_right_black_18pt_1x")
//                        .padding(.top, dWidth * 16/375)
                    VStack{
                        NavigationLink (
                            destination: MapKit_Interface(getlocations: $location, locations: $locationLatLOng).navigationBarHidden(true),
                            isActive: $isLocationSelected,
                            label: {
                                Button(action: {
                                    isLocationSelected.toggle()
                                }, label: {
                                    DropDownList(title:"Business Location", name: "\(location.address ?? "")" != "" ? "\(location.address ?? "")" : "Select location", option: "Change", image: "outline_expand_more_black_18pt_1x")

                                .padding(.top, dWidth * 16/375)
                               
                                })
                            })
                       
                        
                       
                                 
                    }//VStack
                    MobileNumberTextField(textFiled: $vm.businessPhoneText, mobiletext: "Business Phone Number", title: "Please enter here", code: "+64",codeTextField:$vm.businessPhoneCountryCode)
                        .padding(.top, dWidth * 16/375)
                    
                    InputTextField(title: "Website", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.WebsiteText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.WebsiteText)
                        .validate(with: vm.WebsiteText, validation: Validators().nonEmptyValidator)
                        .padding(.top, dWidth * 16/375)
                    
                    //MARK: - NEXT BUTTON
                    NavigationLink (
                        destination: ProfileInfoTwo(fullName: "", service:vm.services, vms: vm, getTrainerProfile: trainerProfileModel, text: text).navigationBarHidden(true),
                        isActive: $isSubmitLinkActive,
                        label: {
                            ButtonCommon(buttonName: "Next", someAction: {
                                let phoneCountryCode = vm.phoneCountryCode + "-" + vm.phoneText
                                let businessCountryCode = vm.businessPhoneCountryCode  + "-" + vm.businessPhoneText
                                trainerProfileModel = TrainerProfileModel(name: vm.fullNameText, phone:phoneCountryCode, lat: locationLatLOng.coordinate.latitude, long: locationLatLOng.coordinate.longitude, location: location.address, business_name: vm.businessNameText, business_phone_number: businessCountryCode, wesbite: vm.WebsiteText)
                                if vm.formValidationsProfileInfo(name: vm.fullNameText, phone: vm.phoneText,businessName:vm.businessNameText,businessLocation: location.address ?? "",businessPhoneNum: vm.businessPhoneText,website: vm.WebsiteText,countryCode: vm.phoneCountryCode,businessCountryCode: vm.businessPhoneCountryCode) {
                                    // SignIn Network Request
                                     
                                            isSubmitLinkActive.toggle()
                                        }
                            })
                        })
                        .alert(isPresented: $vm.isShowAlert) {
                            Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))}
                        .padding(.top, dWidth * 100/375)
                        .padding(.bottom, dWidth * 30/375)
                }.onAppear{
                    vm.loadData()
                }
            } //:VStack
            .padding(.horizontal, dWidth * 16/375)
        } //ZStack
    }
}

struct ProfileInfoOne_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoOne(text: "", fullName: "")
    }
}
