//
//  SignInView.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/16/21.
//

import SwiftUI

struct SignInView: View {
    @State var isSignupLinkActive = false
    //MARK: - PROPERITY
    @StateObject var vm = SignInVM()
    
    var body: some View {
        ZStack{
            backgroundColor
            VStack{
                HeaderView(headerName: "Sign In")
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .center, spacing: 20){
                            
                            Text("LOGO \nHERE")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(Color.green)
                                .font(.system(size: 45, weight: .bold))
                            
                            //MARK: - EMAIL FIELD
                            InputTextField(title: "Email", keyboard: .emailAddress, isValidation: Validators().nonEmptyValidator(value: vm.emailText).isSuccess, isValidationRuntime: $vm.emailValidation, textFiled: $vm.emailText)
                                .validate(with: vm.emailText, validation: Validators().isValidEmailValidator)
                            
                            //MARK: - PASSWORD FIELD
                            InputPasswordField(name: "Password", isValidation: $vm.newPasswordValidation, textfiled: $vm.newPasswordText)
                                .validate(with: vm.newPasswordText, validation: Validators().isValidPasswordValidator)
                            
                            //MARK: - FORGOT PASSWORD
                            NavigationLink(destination: ForgotPasswordView(), label: {
                                Text("Forgot Password?")
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 15))
                            })
                            
                            //MARK: - SIGNIN BUTTON
                            NavigationLink(destination: {
                                //
                            }, label: {
                                ButtonCommon(buttonName: "Sign In", someAction: {
                                    
                                })
                            })
                            Spacer()
                            //MARK: - SIGN UP NAVIGATION
                            HStack{
                                Text("Don't have an account?")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 15))
                                
                                //MARK: - SIGN IN LINK
                                NavigationLink(
                                    destination: UserTypeView(),
                                    isActive: $isSignupLinkActive,
                                    label: {
                                        Button("Sign Up") {
                                            isSignupLinkActive.toggle()
                                        }
                                        .foregroundColor(Color.green)
                                        .font(.system(size: 15))
                                    }
                                )//end navigation view
                                
                            }
                        }
                        
                    }
                    
                }
            }
        }//end zstack
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
