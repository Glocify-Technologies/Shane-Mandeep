//
//  ChangePassword.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-24.
//

import SwiftUI

struct ChangePasswordView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @State var isSubmitLinkActive: Bool = false
    @State var isSignupLinkActive = false

    @State var oldPassword     : String = ""
    @State var newPassword     : String = ""
    @State var confirmPassword : String = ""
    
    @State var showOldPasscode   = false
    @State var showPasscode      = false
    @State var reShowPasscode    = false
    
    @ObservedObject var vm = ChangePasswordVM()
    
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                NavBarWithBackButton(title: "Change Password") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Text("Stay secure and change your password")
                    .font(.custom("SFProText-Regular", size: dWidth * 16/375))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, dWidth * 32/375)

                //MARK: - FULL NAME
                InputPasswordField(name: "Current Password", textfiled: $vm.currentPassword)
                    .validate(with: vm.currentPassword, validation: Validators().isValidPasswordValidator)
                    .padding(.top, dWidth * 8/375)
                
                //MARK: - Email
                InputPasswordField(name: "New Password", textfiled: $vm.newPassword)
                    .validate(with: vm.newPassword, validation: Validators().isValidPasswordValidator)

                InputPasswordField(name: "Confirm Password", textfiled: $vm.confirmPassword)
                    .validate(with: vm.confirmPassword, validation: Validators().isValidPasswordValidator).padding(.bottom, dWidth * 8/375)
                                
                NavigationLink (
                    destination: ResetPasswordView().navigationBarHidden(true),
                    isActive: $isSubmitLinkActive,
                    label: {
                        ButtonCommon(buttonName: "Reset Password", someAction: {
                            
                            if vm.formValidationProfileInfo(password: vm.currentPassword, newPass: vm.newPassword, confirmPass: vm.confirmPassword){
                                vm.changePassword(password: vm.currentPassword, confirmPass: vm.confirmPassword, newPass: vm.newPassword) { success in
                                    isSubmitLinkActive.toggle()
                                }
                            }
                        })
                    }
                ).alert(isPresented: $vm.isShowAlert) {
                    Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))}
                
                Spacer()
                
                NavigationLink(destination: ForgotPasswordView().navigationBarHidden(true), isActive: $isSignupLinkActive){
                    Text("Forgot Password?")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(Color("#00C600"))
                }.padding(.bottom, dWidth * 30/375)
            } //:VStack
            .padding(16)
        } //:ZStack
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
