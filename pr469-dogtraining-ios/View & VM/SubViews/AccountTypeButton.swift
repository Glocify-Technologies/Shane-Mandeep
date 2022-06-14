//
//  AccountTypeButton.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-22.
//

import SwiftUI

struct AccountTypeButton: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])

    var text: String
    var action: (() -> ())

    var body: some View {
        NavigationLink(destination: SignUpView()) {
            Button(action: {
                action()
            }, label: {
                Text(text)
                    .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 15)))
                    .foregroundColor(Color.white)
                    .frame(width: dWidth * 163.5/375, height: dWidth * 80.5/375)
            })
        }
    }
}

//struct AccountTypeButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.blue
//            AccountTypeButton(text: "User")
//        }
//    }
//}
