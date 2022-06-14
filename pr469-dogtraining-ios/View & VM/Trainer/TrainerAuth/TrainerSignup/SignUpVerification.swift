//
//  SignUpVerification.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/17/21.
//

import SwiftUI

struct SignUpVerification: View {
    @State var isProfileOneActive = false
    
    var body: some View {
        ZStack{
           backgroundColor
            VStack{
                HeaderView(headerName: "Sign Up")
                VStack{
                    GeometryReader{ geometry in
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(alignment: .center, spacing: 20){
                                Text("Please enter your verification")
                                    .padding()
                                    .font(ManropeBoldCustom(size: 25))
                                    .foregroundColor(.white)
                                
                                Text("The verification code has been sent to your dedicated email")
                                    .font(ManropeMediumCustom(size: 16))
                                    .foregroundColor(.white)
                                
                                //MARK: - VERIFICATION CODE
                                HStack{
                                    Text("1")
                                        .font(ManropeMediumCustom(size: 16))
                                        .foregroundColor(.white)
                                        .frame(width: 75, height: 75)
                                        .cornerRadius(5.0)
                                        .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.white))
                                    Text("1")
                                        .font(ManropeMediumCustom(size: 16))
                                        .foregroundColor(.white)
                                        .frame(width: 75, height: 75)
                                        .cornerRadius(5.0)
                                        .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.white))
                                    Text("1")
                                        .font(ManropeMediumCustom(size: 16))
                                        .foregroundColor(.white)
                                        .frame(width: 75, height: 75)
                                        .cornerRadius(5.0)
                                        .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.white))
                                    Text("1")
                                        .font(ManropeMediumCustom(size: 16))
                                        .foregroundColor(.white)
                                        .frame(width: 75, height: 75)
                                        .cornerRadius(5.0)
                                        .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.white))
                                }
                                
                                //MARK: - NEXT BUTTON
                                NavigationLink(destination: ProfileInfoOne(fullName: ""),
                                               isActive: $isProfileOneActive,
                                               label: {
                                    ButtonCommon(buttonName: "Next", someAction: {
                                        isProfileOneActive.toggle()
                                    })
                                })
                                
                                Spacer()
                                //MARK: - RESEND LINK
                                HStack{
                                    Text("Didn't receive the verification code?")
                                        .foregroundColor(.white)
                                    Text("Resend")
                                        .foregroundColor(.green)
                                }.font(ManropeMediumCustom(size: 14))
                            }
                        }
                        
                    }
                }
            }
        }//end ZStack
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignUpVerification_Previews: PreviewProvider {
    static var previews: some View {
        SignUpVerification()
    }
}
