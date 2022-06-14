//
//  TypeVerificationCode.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-23.
//

import SwiftUI

struct TypeVerificationCode: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])

    @Binding var textField: String
//    @Binding var textField = "" {
//        didSet {
//            if textField.count > characterLimit && oldValue.count <= characterLimit {
//                textField = oldValue
//            }
//        }
//    }
//    let characterLimit: Int
//
//    init(limit: Int = 1){
//        characterLimit = limit
//    }

    var body: some View {
        VStack {
            TextField("", text: $textField)
                .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 16)))
                .foregroundColor(.white)
                .keyboardType(.phonePad)
                .frame(width: dWidth * 48/375, height: dWidth * 64/375)


        }
    }
}

struct TypeVerificationCode_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            TypeVerificationCode(textField: .constant("1"))
                .multilineTextAlignment(.center)
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: 5).fill(Color.blue)
                        RoundedRectangle (cornerRadius: 5).stroke(Color("#00C600"),lineWidth: 1)
                    })
        }
    }
}

