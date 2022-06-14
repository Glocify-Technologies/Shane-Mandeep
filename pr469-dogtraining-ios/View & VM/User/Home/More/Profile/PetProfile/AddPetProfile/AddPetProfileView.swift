//
//  AddPetProfileView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-13.
//

import SwiftUI

struct AddPetProfileView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    
    @State var profileName: String
    @State var fullNameValidation = false
    @StateObject var vm = AddPetProfileVM()
    @State var isSubmitLinkActive: Bool = false
    
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: dWidth * 16/375) {
                NavBarWithBackButton(title: "Add Pet Profile") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: dWidth * 16/375) {
                    //MARK: - Text Fields
                    InputTextField(title: "Pet Profile Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.petProfileName).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.petProfileName)
                        .validate(with: vm.petProfileName, validation: Validators().nonEmptyValidator)
                        .padding(.top, dWidth * 8/375)
                        .padding(.horizontal, dWidth * 16/375)
                    
                    InputTextField(title: "Pet Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.petName).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.petName)
                        .validate(with: vm.petName, validation: Validators().nonEmptyValidator)
                        .padding(.horizontal, dWidth * 16/375)
                    
                    InputTextField(title: "Breed", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.breed).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.breed)
                        .validate(with: vm.breed, validation: Validators().nonEmptyValidator)
                        .padding(.horizontal, dWidth * 16/375)
                    
                    //MARK: - LOCATION
                    HStack {
                        PetDropDownList(title: "Age", name: "Please select", option: "Change", image: "outline_expand_more_black_18pt_1x")
                        PetDropDownList(title: "Gender", name: "Please select", option: "Change", image: "outline_expand_more_black_18pt_1x")
                    }
                    
                    EditPetProfileBox(title: "Treatment History", message: "Please type here")
                        .padding(.horizontal, dWidth * 16/375)
                    
                    Button(action: {
                    }, label: {
                        HStack {
                            Image("outline_add_black_18pt_1x")
                                .resizable()
                                .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                .foregroundColor(Color("#00C600"))
                            
                            Text("More Treatment History")
                                .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                                .foregroundColor(Color.white)
                                .cornerRadius(dWidth * 22/375)
                                .padding(.trailing, Screen.sizeFromWidth(size: 12))
                        }
                        .padding(.vertical, Screen.sizeFromWidth(size: 3))
                        .padding(.horizontal, Screen.sizeFromWidth(size: 8))
                        .background(
                            ZStack {
                                RoundedRectangle (cornerRadius: dWidth * 22/375).fill(Color("#191919"))
                                RoundedRectangle (cornerRadius: dWidth * 22/375).stroke(Color("#00C600"),lineWidth: dWidth * 0.5/375)
                            })
                    })
                    
                    EditPetProfileBox(title: "Description", message: "Please type here")
                        .padding(.horizontal, dWidth * 16/375)
                    
                    //MARK: - NEXT BUTTON
                    NavigationLink (
                        destination: ProfileTabView().navigationBarHidden(true),
                        isActive: $isSubmitLinkActive,
                        label: {
                            ButtonCommon(buttonName: "Confirm", someAction: {
                                isSubmitLinkActive.toggle()
                            })
                        }
                    ).padding(.bottom, dWidth * 30/375)
                }
                }
            } //:VStack
        } //:ZStack
    }
}

struct AddPetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AddPetProfileView(profileName: "")
    }
}
