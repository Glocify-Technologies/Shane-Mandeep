//
//  Rounded.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-07.
//

import SwiftUI

struct Rounded: Shape {
    
    var radius: Int = 25
    var edges: UIRectCorner = [.topLeft,.topRight]

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: edges, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Rounded_Previews: PreviewProvider {
    static var previews: some View {
        Rounded()
    }
}
