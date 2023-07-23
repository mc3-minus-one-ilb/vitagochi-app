//
//  BackgroundArc.swift
//  Vitagochi
//
//  Created by Enzu Ao on 23/07/23.
//

import SwiftUI

struct BackgroundArc: Shape {
    var yOffset: CGFloat = -50
    
    var animatableData: CGFloat {
        get { return yOffset }
        set { yOffset = newValue}
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - yOffset))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY - yOffset), control: CGPoint(x: rect.midX, y: rect.maxY + yOffset))
        path.closeSubpath()
        
        return path
    }
}
