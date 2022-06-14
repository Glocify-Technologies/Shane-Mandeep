//
//  PrivacyPolicyView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-17.
//

import SwiftUI

struct PrivacyPolicyView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
            ZStack {
                backgroundColor
                    .ignoresSafeArea(.container, edges: .all)
                
                VStack {
                    
                    NavBarWithBackButton(title: "Privacy Policy") {
                        presentationMode.wrappedValue.dismiss()
                    }

                    Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, \nconsectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                        .font(.custom("SF Pro Semibold", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                        .padding(dWidth * 17/375)
                    Spacer()
                } //:VStack
            } //:ZStack
            .navigationBarTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss()}
                    ){
                        Image("ic_back")
                            .foregroundColor(Color.white)
                    }
                }
            } //:ToolBar
       
    }
//    init() {
//        //Use this if NavigationBarTitle is with displayMode = .inline
//        //Changed naviagtionbar title,font and font color
//        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "SFProText-Semibold", size: dWidth * 17/375) as Any, .foregroundColor: UIColor.white]
//    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
