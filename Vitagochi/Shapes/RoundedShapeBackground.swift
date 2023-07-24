//
//  RoundedShapeBackground.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

struct RoundedShape: Shape {
    var radius: CGFloat = 35
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: .init(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
