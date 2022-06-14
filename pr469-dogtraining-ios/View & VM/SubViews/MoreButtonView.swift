//
//  MoreButtonView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-17.
//

import SwiftUI

struct MoreButtonView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var text: String
    var image: String
    var destination: AnyView?
    
    var body: some View {
        NavigationLink(destination: destination.navigationBarHidden(true)) {
//            Button(action: {
////                presentationMode.wrappedValue.dismiss()
//            }){
                HStack(spacing: dWidth * 20/375) {
                    Image(image)
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    
                    Text(text)
                        .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 14)))
                        .foregroundColor(.white)
                    Spacer()
                } //:HStack
                .padding()
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 10/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                        RoundedRectangle (cornerRadius: dWidth * 10/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1.5/375)
                    })
//            }
        }
    }
}

struct MoreButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MoreButtonView(text: "My Profile", image: "baseline_account_circle_black_18pt_1x", destination: AnyView(AboutUsView()))
    }
}
