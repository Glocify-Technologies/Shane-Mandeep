//
//  ResetPasswordView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-13.
//

import SwiftUI

struct ResetPasswordView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var isSignInLinkActive = false

    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                NavBarWithBackButton(title: "Change Password") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Text("Password Changed")
                    .font(.custom("SFProText-Regular", size: dWidth * 22/375))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, dWidth * 26/375)
                
                Text("Stay secure and change your password")
                    .font(.custom("SFProText-Regular", size: dWidth * 16/375))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, dWidth * 7/375)
                                
                NavigationLink (
                    destination: SignInView().navigationBarHidden(true),
                    isActive: $isSignInLinkActive,
                    label: {
                        ButtonCommon(buttonName: "Reset Password", someAction: {
                            isSignInLinkActive.toggle()
                        })
                    }).padding(.top, dWidth * 41/375)
                Spacer()
            } //:VStack
        } //:ZStack
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
