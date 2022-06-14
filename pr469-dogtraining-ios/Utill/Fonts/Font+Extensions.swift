//
//  Font+Extensions.swift
//  pr469-dogtraining-ios
//
//  Created by Sachintha Shanthadewa on 2022-03-31.
//

import SwiftUI

enum DogTrainingFonts: String {
    
       case SFProTextSemibold = "SF Pro Text Semibold"
       case SFProTextBold = "SF Pro Text Bold"
       case SFProTextHeavy = "SF Pro Text Heavy"
       case SFProTextLight = "SF Pro Text Light"
       case SFProTextMedium = "SF Pro Text Medium"
       case SFProTextRegular = "SF Pro Text Regular"
}

extension Font {
    static func customFont( _ name: DogTrainingFonts, _ size: CGFloat) -> Font {
        return Font.custom(name.rawValue, size: size)
    }
}
