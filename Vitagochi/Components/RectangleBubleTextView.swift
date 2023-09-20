//
//  RectangleBubleTextView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

// struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
//        path.closeSubpath()
//        return path
//    }
// }

// TODO: DEFAULT KERNING
let KERNING_SEMUA = -0.8

struct RectangleBubleTextView: View {
    var text: String
    var body: some View {
        Text(text)
            .padding()
            .background(Color.whiteGrayish)
            .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
            .padding(4)
            .font(.system(.body, design: .rounded))
            .fontWeight(.regular)
            .background(Color.whiteFull)
            .foregroundColor(.black)
            .kerning(KERNING_SEMUA)
            .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
            .overlay(alignment: .bottom) {
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.title)
                    .offset(y: 22)
                    .foregroundColor(.whiteFull)
            }
//            .listSectionSeparator(.hidden)
        //        VStack(spacing: 0){
        //            ZStack(alignment: .topLeading) {
        ////                RoundedRectangle(cornerRadius: 12)
        ////                    .foregroundColor(.bubleTextBackgroundColor) // Set the color of the bubble
        ////                    .frame(maxWidth: 269, maxHeight: 94) // Adjust the size as per your text
        //
        //
        //
        //                // Set the text color
        //            }
        //            Triangle()
        //                .fill(Color.bubleTextBackgroundColor)
        //                .frame(width: 33, height: 25)
    }
}

struct RectangleBubleTextView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RectangleBubleTextView(text: "Hello adbansdnansdn")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
        
    }
}
