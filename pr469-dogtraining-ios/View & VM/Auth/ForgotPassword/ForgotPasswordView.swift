//
//  ForgotPasswordView.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject var vm = ForgotPasswordVM()
    @State var isForgotPWResetActive = false
    var body: some View {
        ZStack{
            backgroundColor
            VStack{
                HeaderView(headerName: "Forgot Password")
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .center, spacing: 20){
                            Text("Enter your registered email address below and we’ll send you a password reset email")
                                .font(ManropeMediumCustom(size: 16))
                                .foregroundColor(Color.white)
                                .padding()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            InputTextField(title: "Email", keyboard: .emailAddress, isValidation: Validators().nonEmptyValidator(value: vm.emailText).isSuccess, isValidationRuntime: $vm.emailValidation, textFiled: $vm.emailText)
                                .validate(with: vm.emailText, validation: Validators().isValidEmailValidator)
                            
                            //MARK: - SUBMIT
                            NavigationLink(destination: ForgotPasswordResetView(),
                                           isActive: $isForgotPWResetActive,
                                           label: {
                                ButtonCommon(buttonName: "Submit", someAction: {
                                    isForgotPWResetActive.toggle()
                                })
                            })//end navigation view
                        }
                    }
                    
                }
            }
        }//end ZStack
        .edgesIgnoringSafeArea(.all)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
