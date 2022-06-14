//
//  ChatUserView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-24.
//

import SwiftUI

struct ChatUserView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    var image: String
    var name: String
    var time: String
    var address: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 10/375)
                .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                .background(Color.black.opacity(100).cornerRadius(dWidth * 10/375))
                .frame(width: dWidth * 342.5/375, height: dWidth * 102.5/375)
            
            HStack(spacing: dWidth * 10/375) {
                Image(image)
                    .resizable()
                    .frame(width: dWidth * 70/375, height: dHeight * 70/875, alignment: .center)
                    .cornerRadius(dWidth * 10/375)
                    .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                                .stroke(Color("#E3E3E3"), lineWidth: dWidth * 2/375))
                
                VStack(alignment: .leading, spacing: dWidth * 16/375) {
                    HStack {
                        // Name
                        Text(name)
                            .font(Font.custom("SFProText-Semibold", size: dWidth * 14/375))
                            .foregroundColor(Color.white)
                        Spacer()
                        // Time
                        Text(time)
                            .font(Font.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(Color.white)
                            .padding(.trailing, dWidth * 34/375)

                    }
                    HStack {
                        Text(address)
                            .font(Font.custom("SFProText-Medium", size: dWidth * 13/375))
                            .foregroundColor(Color("#848484"))
                            .lineLimit(1)
                        .frame(width: dWidth * 210/375, height: dWidth * 20/375)
                        Image("baseline_fiber_manual_record_black_18pt_1x")
                            .resizable()
                            .frame(width: dWidth * 10/375, height: dHeight * 10/875, alignment: .center)
                            .foregroundColor(Color("#00C600"))
                            .padding(.trailing, dWidth * 34/375)
                    }
                } //:VStack
            } //:HStack
            .padding(.leading, dWidth * 32/375)
        } //:ZStack
    }
}

struct ChatUserView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ChatUserView(image: "People 09", name: "Jhon Doe", time: "2.13P.M", address: "3 Farland Street, Brockton, MA 0240124685864668")
        }.edgesIgnoringSafeArea(.all)
    }
}
