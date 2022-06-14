//
//  EditProfileView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-13.
//

import SwiftUI

struct EditProfileView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
     let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State var fullName: String
    @State var email: String
    @State var fullNameValidation = false
    @StateObject var vm = ChangePasswordVM()
    @State var isSubmitLinkActive: Bool = false

    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack{
                NavBarWithBackButton(title: "Edit Profile") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                //MARK: - FULL NAME
                InputTextField(title: "Full Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.fullNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.fullNameText)
                    .validate(with: vm.fullNameText, validation: Validators().nonEmptyValidator)
                    .padding(.top, dWidth * 24/375)
                
                //MARK: - Email
                InputTextField(title: "Email", keyboard: .default, isValidation: Validators().isValidEmailValidator(value: vm.email).isSuccess, isValidationRuntime: $vm.emailValidation, textFiled: $vm.email)
                    .validate(with: vm.email, validation: Validators().isValidEmailValidator)
                    .padding(.top, dWidth * 16/375)

                //MARK: - MOBILE
                MobileNumberTextField(textFiled: .constant(""), mobiletext: "Mobile Number", title: "Please enter here", code: "+64", codeTextField: .constant(""))
                    .padding(.horizontal, dWidth * 10/375)
                    .padding(.top, dWidth * 16/375)
                 
                //MARK: - LOCATION
                DropDownList(title: "Hello", name: "Select location", option: "Change", image: "outline_expand_more_black_18pt_1x")
                    .padding(.top, dWidth * 16/375)
                
                Spacer()
                //MARK: - Submit BUTTON
                NavigationLink (
                    destination: MainTabView().navigationBarHidden(true),
                    isActive: $isSubmitLinkActive,
                    label: {
                        ButtonCommon(buttonName: "Submit", someAction: {
                            isSubmitLinkActive.toggle()
                        })
                    }
                ).padding(.bottom, dWidth * 110/375)
            } //:VStack
        } //:ZStack
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(fullName: "", email: "")
    }
}
