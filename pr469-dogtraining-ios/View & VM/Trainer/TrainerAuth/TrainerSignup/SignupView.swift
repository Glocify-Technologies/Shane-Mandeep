//
//  SignUpView.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/17/21.
//

import SwiftUI

struct SignupView: View {
    @StateObject var vm = SignupVM()
    @State var isSignInLinkActive = false
    @State var isSignUpVeriActive = false
    var body: some View {
        ZStack{
           backgroundColor
            VStack{
               HeaderView(headerName: "Sign UP")
                VStack{
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
                                
                                HStack{
                                    Image("")
                                    Text("By ticking this box you agree to our Terms and Conditions and Privacy Policy")
                                        .font(ManropeMediumCustom(size: 14))
                                        .foregroundColor(.white)
                                    
                                  
                                }//end hstack
                                //MARK: - VERIFY BUTTON
                                NavigationLink(destination: SignUpVerification(),
                                               isActive: $isSignUpVeriActive,
                                               label: {
                                    ButtonCommon(buttonName: "Verify Account", someAction: {
                                        isSignUpVeriActive.toggle()
                                    })
                                })
                                Spacer()
                                HStack{
                                    Text("Already have an account?")
                                        .font(ManropeMediumCustom(size: 14))
                                        .foregroundColor(.white)
                                    
                                    NavigationLink(destination: SignInView(),
                                                  isActive: $isSignInLinkActive,
                                                   label: {
                                        Text("Sign In")
                                            .font(ManropeMediumCustom(size: 14))
                                            .foregroundColor(.green)
                                    })
                                }
                            }
                        }
                        
                    }
                }//VStack
            }//end VStack
        }//end ZStack
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
