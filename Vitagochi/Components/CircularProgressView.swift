//
//  CircularProgressView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

struct CircularProgressView: View {
    @State var pulsate = false
    var percentage: CGFloat
    var lineWitdh: CGFloat = 20
    var isBackgroundColor: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
    //            Pulsation()
                Track(size: geometry.size, lineWidth: lineWitdh, isBackgroundColor: isBackgroundColor)
                Outline(percentage: percentage, size: geometry.size, lineWidth: lineWitdh)
                
            }
            .scaleEffect(pulsate ? 1.05 : 1.0)
            .animation( .easeInOut(duration: 1.3).repeatForever(autoreverses: true), value: pulsate)
//    //        .blur(radius: 30)
            .onAppear{
                if pulsate{
                    self.pulsate.toggle()
                }
            }
        }
        
    }
}

struct Outline: View {
    var percentage: CGFloat
    var colors: [Color] = [Color.circularProgressOutline]
    var size: CGSize
    var lineWidth: CGFloat
    
    
    var body : some View {
        ZStack{
            Circle()
                .fill(Color.clear)
                .frame(width: size.width, height: size.height)
                .overlay(
                    Circle()
                        .trim(from: 0, to: percentage * 0.01)
                        .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .top, startAngle: .zero, endAngle: .init(degrees: 360)))
                        .rotationEffect(.init(degrees: 270))
                )
                .animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0), value: percentage)
        }
    }
}

struct Track: View {
    var size: CGSize
    var colors: [Color] = [Color.circularProgressTrack]
    var lineWidth: CGFloat
    var isBackgroundColor: Bool
    
    var body: some View {
        ZStack{
            Circle()
                .fill(isBackgroundColor ? Color.circularProgressBackground : Color.clear)
                .frame(width: size.width, height: size.height)
                .overlay {
                    Circle()
                        .stroke(style:  StrokeStyle(lineWidth: lineWidth))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .center ))
                }
        }
    }
}

//struct Pulsation: View {
//    @State private var pulsate = false
//    var colors: [Color] = [Color.circularProgressPulsating]
//    var body: some View {
//        ZStack{
//            Circle()
//                .fill(Color.circularProgressPulsating)
//                .frame(width: 245, height: 245)
//
//        }
//    }
//}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(percentage: 33)
            .frame(width: 250, height: 250)
    }
}
