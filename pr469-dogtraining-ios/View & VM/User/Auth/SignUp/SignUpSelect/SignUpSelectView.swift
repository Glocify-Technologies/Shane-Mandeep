//
//  SignUpSelectView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-22.
//

import SwiftUI

struct SignUpSelectView: View {
    @EnvironmentObject var viewModel : UserNavigate
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @State var isLoginLinkActive: Bool = false
    @State var isSignupLinkActive = false
    @State var isSelected = 0
    
    @State var isUserTapped = true
    @State var isTrainerTapped = false
    
    var body: some View {
        ZStack {
            Image("bg_img_intro")
                .resizable()
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavBarWithBackButtonTransparent(title: "Sign Up") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                VStack {
                    Text("LOGO \nHERE")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.green)
                        .font(.system(size: 45, weight: .bold))
                    
                    Text("Select Account Type")
                        .font(.custom("SFProText-Bold", size: dWidth * 17/375))
                        .foregroundColor(Color.white)
                        .padding(.top, dWidth * 40/375)
                    
                    //MARK: - SELECT USER TYPE
                    HStack(spacing: dWidth * 15/375) {
                        AccountTypeButton(text: "User", action: {
                            isUserTapped = true
                            isTrainerTapped = false
                            viewModel.isUser = true
                        })
                            .background(
                                ZStack {
                                    RoundedRectangle (cornerRadius: dWidth * 10/375)
                                    if isUserTapped {
                                        Color("#00C600").opacity(0.14).cornerRadius(dWidth * 10/375)
                                    } else {
                                        RoundedRectangle (cornerRadius: dWidth * 10/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                                    }
                                    RoundedRectangle (cornerRadius: dWidth * 10/375).stroke(isUserTapped ? Color("#00C600") : Color("#7E7E7E"),lineWidth: 1)
                                })
                        
                        AccountTypeButton(text: "Trainer", action: {
                            isUserTapped = false
                            isTrainerTapped = true
                            viewModel.isUser = false
                        })
                            .background(
                                ZStack {
                                    RoundedRectangle (cornerRadius: dWidth * 10/375)
                                    if isTrainerTapped {
                                        Color("#00C600").opacity(0.14).cornerRadius(dWidth * 10/375)
                                    } else {
                                        RoundedRectangle (cornerRadius: dWidth * 10/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                                    }
                                    RoundedRectangle (cornerRadius: dWidth * 10/375).stroke(isTrainerTapped ? Color("#00C600") : Color("#7E7E7E"),lineWidth: 1)
                                })
                    } //:HStack
                    .padding(.top, dWidth * 36/375)
                    
                    //MARK: - SIGN UP BUTTON
                    NavigationLink(destination: SignUpView().navigationBarHidden(true), isActive: $isLoginLinkActive){
                        ButtonCommon(buttonName: "Sign Up", someAction: {
                            isLoginLinkActive.toggle()
                        })
                    }
                    .padding(.top, dWidth * 121.5/375)
                    Spacer()
                }
            } //:VStack
        }
    }
}

struct SignUpSelectView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSelectView()
    }
}
