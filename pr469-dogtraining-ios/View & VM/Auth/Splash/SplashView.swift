//
//  SplashView.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/16/21.
//

import SwiftUI

struct SplashView: View {
    @State var isSignupLinkActive = false
    @State var isSigninLinkActive = false
    
    var body: some View {
        
            ZStack{
                Image("bg_img_intro")
                    .resizable()
                    .scaledToFill()
                VStack(spacing: 20){
                    Text("LOGO \nHERE")
                        .foregroundColor(Color.green)
                        .font(.system(size: 45, weight: .bold, design: .default))
                        
                    //MARK: - SIGN UP BUTTON
                    NavigationLink(
                        destination: SignupView(),
                        isActive: $isSignupLinkActive,
                        label: {
                            ButtonCommon(buttonName: "Sign Up", someAction: {
                                isSignupLinkActive.toggle()
                            })
                        }
                    )//end navigation view
                    
                    //MARK: - TEXT
                    Text("Explore as a guest")
                        .foregroundColor(Color.green)
                        .font(.system(size: 15))
                    
                    //MARK: - TEXT
                    HStack{
                        Text("Already have an account?")
                            .foregroundColor(Color.green)
                            .font(.system(size: 15))
                        
                        //MARK: - SIGN IN LINK
                        NavigationLink(
                            destination: SignInView(),
                            isActive: $isSigninLinkActive,
                            label: {
                                Button("Sign In") {
                                    isSigninLinkActive.toggle()
                                }
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                            }
                        )//end navigation view
                        
                    }
                }//end vstack
            }//end zstack
            .edgesIgnoringSafeArea(.all)
            
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
