//
//  RoundedView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-10.
//

import SwiftUI

struct RoundedView: Shape {
    
    var radius: Int = 25
    var edges: UIRectCorner = [.bottomLeft,.topRight]

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: edges, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct RoundedView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedView()
    }
}
