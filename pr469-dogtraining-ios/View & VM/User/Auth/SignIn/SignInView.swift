//
//  SignInView.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/16/21.
//

import SwiftUI

struct SignInView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @State var isLoginLinkActive: Bool = false
    @State var isForgotLinkActive: Bool = false
    @State var isSignupLinkActive = false
    //MARK: - PROPERITY
    @StateObject var vm = SignInVM()
    @State private var showingAlert = false
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                NavBarWithBackButton(title: "Sign In") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                VStack {
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
                    
                    //MARK: - FORGOT PASSWORD
                    NavigationLink(destination: ForgotPasswordView().navigationBarHidden(true), isActive: $isForgotLinkActive){
                        Text("Forgot Password?")
                            .font(.custom("SFProText-Regular", size: dWidth * 15/375))
                            .foregroundColor(Color("#00C600"))
                    }.padding(.top, dWidth * 28/375)
                    
                    //MARK: - SIGNIN BUTTON
                    ButtonCommon(buttonName: "Sign In", someAction: {
                        // Form Validation
                        if vm.formValidationSignIn(email: email, password: password) {
                            // SignIn Network Request
                            vm.signin(email: email, password: password) { success in
                                if success {
                                    let contentView = ContentView(vms: ProfileInfoVM())
                                    UIApplication.shared.windows
                                        .first { $0.isKeyWindow }?
                                        .rootViewController = UIHostingController(rootView: contentView)
                                }
                            }
                        }
                    }).padding(.top, dWidth * 28/375)
                      .disabled(password.count > 7 ? false : true)

                    Spacer()
                    //MARK: - SIGN UP NAVIGATION
                    HStack {
                        Text("Don't have an account?")
                            .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(Color.white)
                        
                        //MARK: - SIGN IN LINK
                        NavigationLink(destination: SignUpSelectView().navigationBarHidden(true), isActive: $isSignupLinkActive){
                            Text("Sign Up")
                                .font(.custom("SFProText-Regular", size: dWidth * 15/375))
                                .foregroundColor(Color("#00C600"))
                        }
                        .alert(isPresented: $vm.showAlert) {
                            Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))
                        }
                    }.padding(.bottom, dWidth * 44/375)
                }
                .padding(.horizontal, dWidth * 16/375)
            }
        } //:ZStack
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
