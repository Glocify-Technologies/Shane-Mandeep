//
//  ForgotPasswordView.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-24.
//

import SwiftUI

struct ForgotPasswordView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @StateObject var vm = ForgotPasswordVM()
    @State var isLoginLinkActive: Bool = false
    @State var email: String = ""

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                NavBarWithBackButton(title: "Forgot Password") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                VStack {
                    Text("Enter your registered email address below and we’ll send you a password reset email")
                        .font(.custom("SFProText-Regular", size: dWidth * 16/375))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, dWidth * 40/375)
                    
                    InputTextField(title: "Email", keyboard: .emailAddress, isValidation: Validators().isValidEmailValidator(value: email).isSuccess, isValidationRuntime: $vm.emailValidation, textFiled: $email)
                        .validate(with: email, validation: Validators().isValidEmailValidator)
                        .padding(.top, dWidth * 24/375)
                    
                    //MARK: - SUBMIT
                    ButtonCommon(buttonName: "Submit", someAction: {
                        // Form Validation
                        if vm.formValidationForgotPassword(email: email) {
                            // SignIn Network Request
                            vm.forgotPassword(email: email) { success in
                                if success {
                                    // Activate ForgotPasswordResetView navigation link
                                    isLoginLinkActive =  true
                                }
                            }
                        }
                    }).padding(.top, dWidth * 24/375)

                    // Navigation link ForgotPasswordResetView
                    NavigationLink(destination: ForgotPasswordResetView(email: email).navigationBarHidden(true), isActive: $isLoginLinkActive){
                    }
                    Spacer()
                } //:VStack
                .padding(.horizontal, dWidth * 16/375)
            } //:VStack
        } //:ZStack
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
