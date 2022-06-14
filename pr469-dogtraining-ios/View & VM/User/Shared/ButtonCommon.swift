//
//  ButtonCommon.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/16/21.
//

import SwiftUI

struct ButtonCommon: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])

    var buttonName: String
    var someAction: (() -> ())
    
    var body: some View {
        Button(action: {
            someAction()
        }, label: {
            Text(buttonName)
                .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding()
                .frame(width: dWidth * 220/375, height: dWidth * 48/375)
                .cornerRadius(dWidth * 22/375)
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 22/375).fill(Color("#00A100"))
                        RoundedRectangle (cornerRadius: dWidth * 22/375).stroke(Color("#5CFF5C"),lineWidth: dWidth * 1.5/375)
                    })

        })
    }
}

struct ButtonCommonLarge: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])

    var buttonName: String
    var someAction: (() -> ())
    
    var body: some View {
        Button(action: {
            someAction()
        }, label: {
            Text(buttonName)
                .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding()
                .frame(width: dWidth * 343/375, height: dWidth * 48/375)
                .cornerRadius(dWidth * 22/375)
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 22/375).fill(Color("#00A100"))
                        RoundedRectangle (cornerRadius: dWidth * 22/375).stroke(Color("#5CFF5C"),lineWidth: dWidth * 1.5/375)
                    })

        })
    }
}

struct ButtonCommonBlack: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])

    var buttonName: String
    var someAction: (() -> ())
    var color: String
    
    var body: some View {
        Button(action: {
            someAction()
        }, label: {
            Text(buttonName)
                .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                .foregroundColor(Color(color))
                .padding()
                .frame(width: dWidth * 220/375, height: dWidth * 48/375)
                .cornerRadius(dWidth * 22/375)
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 22/375).fill(Color("#191919"))
                        RoundedRectangle (cornerRadius: dWidth * 22/375).stroke(Color("#5CFF5C"),lineWidth: dWidth * 0.5/375)
                    })

        })
    }
}

struct ButtonCommonLarge_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ButtonCommonLarge(buttonName: "Hello", someAction: {})
        }
    }
}

struct ButtonCommonBlack_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ButtonCommonBlack(buttonName: "Hello", someAction: {}, color: "00C600")
        }
    }
}

struct ButtonCommon_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ButtonCommon(buttonName: "Hello", someAction: {})
        }
    }
}
