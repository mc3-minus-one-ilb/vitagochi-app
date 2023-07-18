//
//  RectangleBubleTextView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct RectangleBubleTextView: View {
    var text: String
    var body: some View {
        VStack(spacing: 0){
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.bubleTextBackgroundColor) // Set the color of the bubble
                    .frame(maxWidth: 269, maxHeight: 94) // Adjust the size as per your text
                
                Text(text)
                    .font(.system(size: 17, weight: .regular, design: .rounded))
//                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .kerning(-0.4)
                    .padding(10)
                // Set the text color
            }
            Triangle()
                .fill(Color.bubleTextBackgroundColor)
                .frame(width: 33, height: 25)
               
            
        }
        
    }
}

struct RectangleBubleTextView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleBubleTextView(text: "Hello")
    }
}
