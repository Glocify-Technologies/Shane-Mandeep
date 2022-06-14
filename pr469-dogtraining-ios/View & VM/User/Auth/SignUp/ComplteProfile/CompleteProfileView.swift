//
//  CompleteProfileView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-23.
//

import SwiftUI
import CoreLocation

struct CompleteProfileView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    
    @State var fullName: String
    @State var fullNameValidation = false
    @StateObject var vm = ProfileInfoVM()
    @State var isSubmitLinkActive: Bool = false

    @State private var isScrollExpanded = false
    @State var ageList = Array(10...100)
    @State var selection = 10
  
    @State var isAgeSelected = false
    @State var location = Location()
    @State var isLocationSelected = false
    @State var locationLatLOng = CLLocation()
   
    var body: some View {
        ZStack(alignment: .top){
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            NavBarWithBackButton(title: "Complete Your Profile") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.top, 48)
            
            VStack {
                
                //MARK: - FULL NAME
                InputTextField(title: "Full Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.fullNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.fullNameText)
                    .validate(with: vm.fullNameText, validation: Validators().nonEmptyValidator)
                    .padding(.top, dWidth * 56/375)
                //MARK: - MOBILE
                MobileNumberTextField(textFiled: $vm.phoneText, mobiletext: "Mobile Number", title: "Please enter here", code: "+64", codeTextField: $vm.phoneCountryCode)
                    .padding(.top, dWidth * 16/375)
                 
                //MARK: - LOCATION

                VStack{
                    NavigationLink (
                        destination: MapKit_Interface(getlocations: $location, locations: $locationLatLOng).navigationBarHidden(true),
                        isActive: $isLocationSelected,
                        label: {
                            Button(action: {
                                isLocationSelected.toggle()
                            }, label: {
                                DropDownList(title:"Location", name: "\(location.address ?? "")" != "" ? "\(location.address ?? "")" : "Select location", option: "Change", image: "outline_expand_more_black_18pt_1x")

                            .padding(.top, dWidth * 16/375)
                           
                            })
                        })
                   
                    
                   
                             
                }//VStack

                //MARK: - Age
                VStack{
                    Button(action: {
                        isAgeSelected.toggle()
                    }, label: {
                        DropDownList(title: "Age", name: selection < 10 ? "Please select" : "\(selection) Years", option: "", image: "outline_expand_more_black_18pt_1x")
                    .padding(.top, dWidth * 16/375)
                    })
                    
                    if isAgeSelected{
                        PickerView(
                                 pickerOptions: ageList,
                                 width: 300,
                                 height: 150,
                                 showPicker: $isAgeSelected,
                                 selectedPickerOption: $selection
                        
                        )
                            .foregroundColor(Color.white)
                    }
                             
                }//VStack
                
                Spacer()
                //MARK: - NEXT BUTTON
                NavigationLink (
                    destination: MainTabView().navigationBarHidden(true),
                    isActive: $isSubmitLinkActive,
                    label: {
                        ButtonCommon(buttonName: "Submit", someAction: {
                           
                            if vm.formValidationProfileInfo(name: vm.fullNameText, phone: vm.phoneText) {
                                // SignIn Network Request
                               
                                vm.setUpProfileInfo(name: vm.fullNameText, location: location.address ?? "", lat: "\(locationLatLOng.coordinate.latitude)", long: "\(locationLatLOng.coordinate.longitude)", phone: vm.phoneText, age: "\(selection)") { success in
                                    if success {
                                        // Activate Verification navigation link
//                                        isVerifyLinkActive =  true
                                        isSubmitLinkActive.toggle()
                                    }
                                }
                            }
                        })
                    }
                ).padding(.bottom, dWidth * 67.5/375)
                    .alert(isPresented: $vm.isShowAlert) {
                        Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))}
            } //:VStack
            .padding(.horizontal, dWidth * 16/375)
            .padding(.top, dWidth * 48/375)
        } //:ZStack
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct CompleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteProfileView(fullName: "")
    }
}
