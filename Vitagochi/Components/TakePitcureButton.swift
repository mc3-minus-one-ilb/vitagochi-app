//
//  TakePitcureButton.swift
//  Vitagochi
//
//  Created by Enzu Ao on 21/07/23.
//

import SwiftUI

struct TakePitcureButton: View {
    @Binding var isCameraClicked: Bool
    @State var disable: Bool = true
    @State var animation: Bool = false
    var timePhase: VitaTimePhase
    var isCompleted: Bool
    
    var body: some View {
        let isItPassMealTime = timePhase.icon.isEmpty
        return ZStack(alignment: .center) {
            Button {
                if !isItPassMealTime && !isCompleted {
                    isCameraClicked.toggle()
                }
                
            } label: {
                // TODO: Blink Effect Animation
                ZStack {
                    Circle()
                        .foregroundColor(!isItPassMealTime && !isCompleted ? .mintPrimary : .gray3)
                        .frame(width: 66)
                    Image(systemName: "camera.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(!isItPassMealTime && !isCompleted ?
                            .blackGreen : .gray2 )
                        .frame(width: 30, height: 24, alignment: .center)
                }
                
            }
            
                //                Circle()
                
                //                    .stroke(style: .init(lineWidth: 4, dash: [30,1]))
                //                    .foregroundColor(.chatTopPinkColor)
                //                    .frame(width: 70)
                //                    .rotationEffect(animation ? Angle(degrees: 360.0) : .zero)
                //                    .animation(.linear(duration: 20).repeatForever(autoreverses: true), value: animation)
                //                    .onAppear {
                //                        animation.toggle()
                //                    }
                //                    .rotationEffect()
         
        }
    }
}

struct TakePitcureButton_Previews: PreviewProvider {
    static var previews: some View {
        TakePitcureButton(
            isCameraClicked: .constant(false),
            timePhase: .afternoon,
            isCompleted: false)
    }
}
