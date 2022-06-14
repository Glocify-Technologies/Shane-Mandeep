//
//  serviceView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-11.
//

import SwiftUI

struct serviceView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @Binding var text: String
    var image: String
    var title: String
    

    
    var body: some View {
        VStack(alignment: .leading){
           Text(title)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 16/375)
            
                HStack(spacing: dWidth * 20/375) {
                    Image(image)
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    TextField("100", text: $text)
                        .foregroundColor(.white)
                        .keyboardType(.decimalPad)
//                    Text(text)
//                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                        .foregroundColor(.white)
                    Spacer()
                } //:HStack
                .padding()
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 10/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                        RoundedRectangle (cornerRadius: dWidth * 10/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1.5/375)
                    })
            }
        
    }
}


