//
//  PetProfileView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-13.
//

import SwiftUI

struct PetProfileView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    
    @State var fullNameValidation = false
    @StateObject var vm = AddPetProfileVM()
    @State var isSubmitLinkActive: Bool = false

    var body: some View {
        ZStack{
            backgroundColor
            VStack(spacing: dWidth * 16/375) {                            
                ZStack {
                    RoundedRectangle(cornerRadius: dWidth * 10/375)
                        .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                        .foregroundColor(Color("#191919").opacity(0.26))
                        .frame(width: dWidth * 342.5/375, height: dWidth * 400/375)
                    
                    VStack(alignment: .leading, spacing: dWidth * 10/375) {
                        HStack {
                            Text("Pet Profile 1")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 16/375))
                                .foregroundColor(Color("#C3C3C3"))
                            Spacer()
                            NavigationLink (
                                destination: EditPetProfileView(profileName: "").navigationBarHidden(true),
                                isActive: $isSubmitLinkActive,
                                label: {
                                    Image("outline_edit_black_18pt_1x")
                                        .resizable()
                                        .frame(width: dWidth * 24/375, height: dHeight * 24/875, alignment: .center)
                                        .foregroundColor(Color("#00C600"))
                                }
                            )
                        } //:HStack
                        .padding(.bottom, dWidth * 10/375)
                        
                        Text("Pet Name")
                            .font(Font.custom("SFProText-Regular", size: dWidth * 12/375))
                            .foregroundColor(Color("#848484"))
                        Text("Coffee")
                            .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                            .foregroundColor(Color("#C3C3C3"))
                            .padding(.bottom, dWidth * 10/375)

                        HStack(spacing: dWidth * 40/375) {
                            Text("Breed")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
                            Spacer()
                            Text("Age")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
                            Text("Gender")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
                            Spacer()
                        } //:HStack
                        .padding(.bottom, dWidth * 10/375)

                        HStack(spacing: dWidth * 65/375) {
                            Text("Border Collie")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color.white)
                                .lineLimit(1)
                            Text("3")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color.white)
                            Text("M")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color.white)
                            Spacer()
                        } //:HStack
                        .padding(.bottom, dWidth * 10/375)

                        Text("Treatment History")
                            .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                            .foregroundColor(Color("#7E7E7E"))
                        Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ")
                            .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                            .foregroundColor(Color.white)
                            .padding(.bottom, dWidth * 10/375)

                        Text("Description")
                            .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                            .foregroundColor(Color("#7E7E7E"))
                        Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ")
                            .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                            .foregroundColor(Color.white)
                    } //:VStack
                    .padding(dWidth * 33/375)
                } //:ZStack
                
                Spacer()
                //MARK: - NEXT BUTTON
                NavigationLink (
                    destination: AddPetProfileView(profileName: "").navigationBarHidden(true),
                    isActive: $isSubmitLinkActive,
                    label: {
                        ButtonCommon(buttonName: "Add Pet Profile", someAction: {
                            isSubmitLinkActive.toggle()
                        })
                    }
                ).padding(.bottom, dWidth * 67.5/375)
            } //:VStack
        } //:ZStack
        .edgesIgnoringSafeArea(.all)
    }
}

struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PetProfileView()
    }
}
