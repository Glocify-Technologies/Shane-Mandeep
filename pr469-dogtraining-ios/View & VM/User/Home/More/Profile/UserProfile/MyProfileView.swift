//
//  MyProfileView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-17.
//

import SwiftUI

struct MyProfileView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @State var isCompleteEditLinkActive: Bool = false
    @State var isCompletePasswordLinkActive: Bool = false
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack() {
                NavBarWithoutBackButtonTransparent(title: "Bookings") {
                    presentationMode.wrappedValue.dismiss()
                }
                                
                ZStack(alignment: .bottomTrailing) {
                    Image("People 06")
                        .resizable()
                        .frame(width: dWidth * 150/375, height: dHeight * 150/875, alignment: .center)
                        .cornerRadius(dWidth * 10/375)
                        .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                                    .stroke(Color("#E3E3E3"), lineWidth: dWidth * 2/375))
                    Image("baseline_add_box_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 32/375, height: dHeight * 32/875, alignment: .center)
                        .foregroundColor(Color("#00C600"))
                        .offset(x: dWidth * 20/375, y: dWidth * 15/375)
                }
                
                Text("Emily Wilson")
                    .font(.custom("SFProText-Bold", size: dWidth * 20/375))
                    .foregroundColor(.white)
                    .padding(.top, dWidth * 20/375)
                HStack {
                    Image("baseline_email_black_12pt_1x")
                        .resizable()
                        .frame(width: dWidth * 18/375, height: dHeight * 18/875, alignment: .center)
                        .foregroundColor(Color("#00C600"))
                    Text("emily_wilson@gmail.com")
                        .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                        .foregroundColor(.white)
                } //:HStack
                HStack {
                    Image("baseline_call_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 18/375, height: dHeight * 18/875, alignment: .center)
                        .foregroundColor(Color("#00C600"))
                    Text("0444 999 021")
                        .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                        .foregroundColor(.white)
                } //:HStack
                
                Spacer()
                
                NavigationLink (
                    destination: EditProfileView(fullName: "", email: "").navigationBarHidden(true),
                    isActive: $isCompleteEditLinkActive,
                    label: {
                        ButtonCommon(buttonName: "Edit Profile", someAction: {
                            isCompleteEditLinkActive.toggle()
                        })
                    }).padding(.bottom, dWidth * 16/375)
                NavigationLink (
                    destination: ChangePasswordView().navigationBarHidden(true),
                    isActive: $isCompletePasswordLinkActive,
                    label: {
                        ButtonCommonBlack(buttonName: "Change Password", someAction: {
                            isCompletePasswordLinkActive.toggle()
                        }, color: "#FFFFFF")
                    }).padding(.bottom, dWidth * 110/375)
            } //:VStack
        } //:ZStack
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
