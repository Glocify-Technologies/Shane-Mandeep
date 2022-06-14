//
//  SplashView.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/16/21.
//

import SwiftUI

struct SplashView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State var isSignupLinkActive = false
    @State var isSigninLinkActive = false
    
    var body: some View {
//        NavigationView{
            ZStack{
                Image("bg_img_intro")
                    .resizable()
//                    .frame(width: dHeight, height: dHeight)
                    .clipped()
                
                VStack {
                    Text("LOGO \nHERE")
                        .foregroundColor(Color.green)
                        .font(.system(size: dWidth * 50/375, weight: .bold))
                        .padding(.top, dWidth * 200/375)
                    
                    //MARK: - SIGN UP BUTTON
                    NavigationLink (
                        destination: SignUpSelectView ().navigationBarHidden(true),
                        isActive: $isSignupLinkActive,
                        label: {
                            ButtonCommon(buttonName: "Sign Up", someAction: {
                                isSignupLinkActive.toggle()
                            })
                        }).padding(.top, dWidth * 60/375)
                    
                    NavigationLink (
                        destination: MainTabView().navigationBarHidden(true),
                        label: {
                            Text("Explore as a guest")
                                .font(.custom("SF Pro Semibold", size: dWidth * 15/375))
                                .foregroundColor(Color("#00C600"))
                        }).padding(.top, dWidth * 42/375)
                    
                    Spacer()
                    HStack {
                        Text("Already have an account?")
                            .font(.custom("SF Pro Semibold", size: dWidth * 15/375))
                            .foregroundColor(.white)
                         
                        //MARK: - SIGN IN LINK
                        NavigationLink (
                            destination: SignInView().navigationBarHidden(true),
                            isActive: $isSigninLinkActive,
                            label: {
                                Button("Sign In") {
                                    isSigninLinkActive.toggle()
                                }
                                .font(.custom("SF Pro Semibold", size: dWidth * 15/375))
                                .foregroundColor(Color("#00C600"))
                            })
                    }.padding(.bottom, dWidth * 44/375)
                } //:VStack
            } //:ZStack
            .ignoresSafeArea()
//        } //:NavigationView
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
