//
//  RoundedShape.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

struct BubbleArrow: Shape {
    var isMyMessage: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: isMyMessage ?
                [.topLeft, .topRight, .bottomLeft] : [.topRight, .topLeft, .bottomRight],
            cornerRadii: .init(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}
