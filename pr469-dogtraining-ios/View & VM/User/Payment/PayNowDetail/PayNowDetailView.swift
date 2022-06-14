//
//  PayNowDetailView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-03-14.
//

import SwiftUI

struct PayNowDetailView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @StateObject var vm = ForgotPasswordVM()
    @State var isLoginLinkActive: Bool = false
    @State var saveCard: Bool = false
    
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                NavBarWithBackButton(title: "Pay Now") {
                    presentationMode.wrappedValue.dismiss()
                }
                VisaCardDetails()
                    .padding(.horizontal, Screen.sizeFromWidth(size: 16))
                
                DropDownList(title: "Country", name: "Please select", option: "", image: "outline_expand_more_black_18pt_1x")
                    .padding(Screen.sizeFromWidth(size: 16))
                
                HStack(spacing: 12){
                    Button {
                        saveCard.toggle()
                    } label: {
                        ZStack {
                            Image("outline_check_box_outline_blank_black_18pt_1x")
                                .resizable()
                                .frame(width: Screen.sizeFromWidth(size: 24), height: Screen.sizeFromWidth(size: 24))
                            if saveCard {
                                Image("ic_done")
                                    .resizable()
                                    .padding(Screen.sizeFromWidth(size: 4))
                                    .frame(width: Screen.sizeFromWidth(size: 24), height: Screen.sizeFromWidth(size: 24))
                            }
                        }
                        .foregroundColor(Color("#00C600"))
                    }.padding(.leading, Screen.sizeFromWidth(size: 16))
                    
                    Text("Save this card")
                        .font(.custom("SFProText-SemiBold", size: Screen.sizeFromWidth(size: 14)))
                        .foregroundColor(Color.white)
                    Spacer()
                } //:HStack
                
                HStack {
                    Text("Total Cost")
                        .font(.custom("SFProText-Regular", size: Screen.sizeFromWidth(size: 16)))
                        .foregroundColor(Color.white)
                    Spacer()
                    Text("$100")
                        .font(.custom("SFProText-Regular", size: Screen.sizeFromWidth(size: 16)))
                        .foregroundColor(Color.white)
                }
                .padding(.horizontal, Screen.sizeFromWidth(size: 16))
                .padding(.top, Screen.sizeFromWidth(size: 30))
                
                ButtonCommon(buttonName: "Pay Now $100", someAction: {
                }).padding(.top, Screen.sizeFromWidth(size: 40))

                Spacer()
            } //:VStack
        } //:ZStack
    }
}

struct PayNowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PayNowDetailView()
    }
}
