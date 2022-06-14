//
//  ProfileTabView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-19.
//

import SwiftUI
import RappleProgressHUD

struct ProfileTabView: View {
    @State var tab = 0
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    
    @State var fullNameValidation = false
    @StateObject var vm = AddPetProfileVM()
    @State var isSubmitLinkActive: Bool = false
    @State var selectedTab = 0

    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: dWidth * 16/375) {
                NavBarWithBackButton(title: "Profile") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ToggleButton(selectedTab: $selectedTab)
                    .padding(.bottom, dWidth * 24/375)

                switch selectedTab {
                case 0:
                    MyProfileView()
                case 1:
                    PetProfileView()
                default:
                    MyProfileView()
                }
            } //:VStack
        } //:ZStack
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView()
    }
}
