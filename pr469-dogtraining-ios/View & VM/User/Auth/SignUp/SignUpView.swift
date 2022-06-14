//
//  SignUpView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-22.
//

import SwiftUI

struct SignUpView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @StateObject var vm = SignUpVM()
    @State var isVerifyLinkActive = false
    @State var isSigninLinkActive = false
    @State private var showingAlert = false
    @State var email: String = ""
    @State var password: String = ""
    @State var agreeToTerms: Bool = false
    @EnvironmentObject var navigation: UserNavigate
    @State var userRole: String = ""
    
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                NavBarWithBackButton(title: "Sign Up") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Text("LOGO \nHERE")
                    .foregroundColor(Color.green)
                    .font(.system(size: dWidth * 40/375, weight: .bold))
                    .lineLimit(2)
                
                //MARK: - EMAIL FIELD
                InputTextField(title: "Email", keyboard: .emailAddress, isValidation: Validators().isValidEmailValidator(value: email).isSuccess, isValidationRuntime: $vm.emailValidation, textFiled: $email)
                    .validate(with: email, validation: Validators().isValidEmailValidator)
                    .padding(.top, dWidth * 50/375)
                
                //MARK: - PASSWORD FIELD
                InputPasswordField(name: "Password", textfiled: $password)
                    .validate(with: password, validation: Validators().isValidPasswordValidator)
                    .padding(.top, dWidth * 16/375)
                
                HStack(spacing: 24){
                    Button {
                        agreeToTerms.toggle()
                    } label: {
                        ZStack {
                            Image("outline_check_box_outline_blank_black_18pt_1x")
                                .resizable()
                                .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                            if agreeToTerms {
                                Image("ic_done")
                                    .resizable()
                                    .padding(dWidth * 4/375)
                                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                            }
                        }
                        .foregroundColor(Color("#00C600"))
                    }
                    
                    Text("By ticking this box you agree to our Terms and Conditions and Privacy Policy")
                        .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                } //:HStack
                .padding(.top, dWidth * 16/375)
                
                //MARK: - VERIFY BUTTON
                ButtonCommon(buttonName: "Verify Account", someAction: {
                //    isVerifyLinkActive =  true
                    // Form Validation
                    if vm.formValidationSignUp(email: email, password: password, termsCheck: agreeToTerms) {
                        // SignIn Network Request
                        if navigation.isUser {
                            userRole = "USER"
                        }
                        else {
                            userRole = "TRAINER"
                           
                        }
                        vm.signup(userRole: userRole, email: email, password: password) { success in
                            if success {
                                // Activate Verification navigation link
                                if userRole == "TRAINER"{
                                    vm.stripeConnect { success in
                                       
                                    }
                                }
                               
                                isVerifyLinkActive =  true
                            }
                        }
                    }
                }).padding(.top, dWidth * 24/375)
                    .disabled(password.count > 7 ? false : true)
//                 Use to Navigate Verification view
                NavigationLink (
                    destination: SignUpVerificationView().navigationBarHidden(true),
                    isActive: $isVerifyLinkActive,
                    label: {
                    })
                
                Spacer()
                HStack{
                    Text("Already have an account?")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                    NavigationLink (
                        destination: SignInView().navigationBarHidden(true),
                        isActive: $isSigninLinkActive,
                        label: {
                            Button("Sign In") {
                                isSigninLinkActive.toggle()
                            }
                            .font(.custom("SF Pro Semibold", size: dWidth * 15/375))
                            .foregroundColor(Color("#00C600"))
                        }
                    )
                }.padding(.bottom, dWidth * 32/375)
            } //:VStack
            .padding(.horizontal, dWidth * 16/375)
        } //:ZStack
       
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage),primaryButton: .cancel(), secondaryButton: .default(Text(vm.alertMessage == .termsCheck ?"Ok" :"Sign In")){
                if vm.alertMessage != .termsCheck{
                    isSigninLinkActive = true
                }
                    
                })
//            }
           
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
