//
//  ForgotPasswordResetView.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/16/21.
//

import SwiftUI

struct ForgotPasswordResetView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var email: String = ""
    @StateObject var vm = ForgotPasswordVM()
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack{
                NavBarWithBackButton(title: "Forgot Password") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                VStack {
                    Text("Please Check Your Email")
                        .font(.custom("SFProText-Regular", size: dWidth * 22/375))
                        .foregroundColor(Color.white)
                        .padding(.top, dWidth * 35/375)
                    
                    Text("A password reset link has been sent to your dedicated email")
                        .font(ManropeMediumCustom(size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, dWidth * 24/375)
 
                    HStack{
                        Text("Didn't receive the link?")
                            .font(ManropeMediumCustom(size: dWidth * 14/375))
                            .foregroundColor(Color.white)
                        
//                        Text("Resend")
//                            .font(ManropeMediumCustom(size: dWidth * 14/375))
//                            .foregroundColor(Color("#00C600"))
                        Button(action: {
                            print("Button action")
                            if vm.formValidationForgotPassword(email: email) {
                                // SignIn Network Request
                                vm.forgotPassword(email: email) { success in
                                    if success {
                                        // Activate ForgotPasswordResetView navigation link
//                                        isLoginLinkActive =  true
                                    }
                                }
                            }
                        }) {
                            Text("Resend")
                                .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                                .foregroundColor(Color("#00C600"))                    }
                    }.padding(.top, dWidth * 33/375)

                    Spacer()
                } //:VStack
                .padding(.horizontal, dWidth * 16/375)
            } //:VStack
        }
                .alert(isPresented: $vm.showAlert) {
                    Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))
                }
    }
}

struct ForgotPasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordResetView()
    }
}
