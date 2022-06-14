//
//  ContactUsButtonView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-20.
//

import SwiftUI

struct ContactUsButtonView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var text: String
    var image: String
    var destination: AnyView
    
    var body: some View {
        Button(action: { presentationMode.wrappedValue.dismiss()
        }){
            NavigationLink(destination: destination.navigationBarHidden(true)) {
                HStack(spacing: dWidth * 20/375) {
                    Image(image)
                        .resizable() 
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Spacer()
                    Text(text)
                        .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 14)))
                        .foregroundColor(.white)
                    //Padding should be checked
                        .padding(.trailing,50)
                    Spacer()
                } //:HStack
                .padding()
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 10/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                        RoundedRectangle (cornerRadius: dWidth * 10/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1.5/375)
                    })
            }
        }.padding(.horizontal,16)
    }
}

struct ContactUsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsButtonView(text: "My Profile", image: "outline_open_in_new_black_12pt_1x", destination: AnyView(AboutUsView()))
    }
}
