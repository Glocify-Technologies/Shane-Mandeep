//
//  NavBarWithBackButton.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-21.
//

import SwiftUI

struct NavBarWithBackButton: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width

    var title: String
    var action: (() -> ())?
    
    var body: some View {
        return ZStack {
            Color("backgroundColor")
            
            Text(title)
                .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 17)))
                .foregroundColor(Color.white)
            
            HStack {
                Image("ic_back")
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        action?()
                    }
                Spacer()
            }
        }
        .frame(height: dWidth * 50/375)
        .background(Color.black)
    }
}

struct NavBarWithBackButtonTransparent: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width

    var title: String
    var action: (() -> ())?
    
    var body: some View {
        return ZStack {
//            Color("backgroundColor")
//                .opacity(100)
            
            Text(title)
                .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 17)))
                .foregroundColor(Color.white)
            
            HStack {
                Image("ic_back")
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        action?()
                    }
                Spacer()
            }
        }
        .frame(height: dWidth * 50/375)
        .background(Color.black.opacity(0))
    }
}

struct NavBarWithoutBackButtonTransparent: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width

    var title: String
    var action: (() -> ())?
    
    var body: some View {
        return ZStack {
//            Color("backgroundColor")
//                .opacity(100)
            
            Text(title)
                .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 17)))
                .foregroundColor(Color.white)
            
            HStack {
//                Image("ic_back")
//                    .foregroundColor(Color.white)
//                    .onTapGesture {
//                        action?()
//                    }
                Spacer()
            }
        }
        .frame(height: dWidth * 50/375)
        .background(Color.black.opacity(0))
        .padding(.top, (UIDevice.modelName.contains("iPhone 8 Plus") || UIDevice.modelName.contains("iPhone 7") || UIDevice.modelName.contains("iPhone 7 Plus") || UIDevice.modelName.contains("iPhone 8") || UIDevice.modelName.contains("iPhone SE")) ? dWidth*32/375 : dWidth*40/375)
    }
}

struct NavBarWithoutBackButtonTransparent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green
            NavBarWithoutBackButtonTransparent(title: "Hello")
        }
    }
}

struct NavBarWithBackButtonTransparent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green
            NavBarWithBackButtonTransparent(title: "Hello")
        }
    }
}

struct NavBarWithBackButton_Previews: PreviewProvider {
    static var previews: some View {
        NavBarWithBackButton(title: "Hello")
    }
}
