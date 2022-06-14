//
//  ViewNotificationView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-10.
//

import SwiftUI

struct ViewNotificationView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
   
    var title: String
    var time: String
    var content: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 10/375)
                .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                .background(Color.black.opacity(100).cornerRadius(dWidth * 10/375))
                .frame(width: dWidth * 342.5/375, height: dWidth * 102.5/375)
            
            HStack(spacing: dWidth * 10/375) {

                
                VStack(alignment: .leading, spacing: dWidth * 16/375) {
                    HStack {
                        // Name
                        Text(title)
                            .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 14)))
                            .foregroundColor(Color.white)
                        Spacer()
                        // Time
                        Text(time)
                            .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 14)))
                            .foregroundColor(Color.white)
                            .padding(.trailing, dWidth * 34/375)

                    }
                    HStack {
                        Text(content)
                            .font(.customFont(.SFProTextMedium, Screen.sizeFromWidth(size: 13)))
                            .foregroundColor(Color("#848484"))
                           
                       
                    }
                } //:VStack
            } //:HStack
            .padding(.leading, dWidth * 32/375)
        } //:ZStack
    }
}

