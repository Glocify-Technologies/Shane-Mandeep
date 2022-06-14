//
//  VisaCardDetails.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-03-14.
//

import SwiftUI

struct VisaCardDetails: View {
    var body: some View {
        HStack(spacing: Screen.sizeFromWidth(size: 16)) {
            Image("imgVisa")
                .resizable()
                .frame(width: Screen.sizeFromWidth(size: 47), height: Screen.sizeFromWidth(size: 30), alignment: .center)
            Text("XXXX 5269")
                .font(Font.custom("SFProText-Bold", size: Screen.sizeFromWidth(size: 14)))
                .foregroundColor(Color.white)
            Spacer()
            Text("MM/YY")
                .font(Font.custom("SFProText-Bold", size: Screen.sizeFromWidth(size: 14)))
                .foregroundColor(Color.white)
            Text("CVC")
                .font(Font.custom("SFProText-Bold", size: Screen.sizeFromWidth(size: 14)))
                .foregroundColor(Color.white)
                .padding(.trailing, Screen.sizeFromWidth(size: 16))
        }
        .padding(Screen.sizeFromWidth(size: 5))
        .background(
            RoundedRectangle(cornerRadius: Screen.sizeFromWidth(size: 10))
                .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                .foregroundColor(Color.black.opacity(0.26))
        )
    }
}

struct VisaCardDetails_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            VisaCardDetails()
        }
    }
}
