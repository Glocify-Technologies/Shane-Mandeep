//
//  EditPetProfileBox.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-16.
//

import SwiftUI

struct EditPetProfileBox: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    
    var title: String
    var message: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 14)))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 16/375)

            Text(message)
                .lineLimit(3)
                .font(.customFont(.SFProTextMedium, Screen.sizeFromWidth(size: 14)))
                .foregroundColor(Color.white)
                .padding(dWidth * 16/375)
                .padding(.bottom, dWidth * 40/375)
                .padding(.trailing, dWidth * 270/375)
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 10/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                        RoundedRectangle (cornerRadius: dWidth * 10/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 0.5/375)
                    }
                )
        }
    }
}

struct EditPetProfileBox_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            EditPetProfileBox(title: "Treatment History", message: "Please type here")
        }
    }
}
