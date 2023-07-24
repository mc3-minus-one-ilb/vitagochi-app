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
    var timePhase: VitachiTimePhase
    var isCompleted: Bool
    
    
    var body: some View {
        let isItPassMealTime = timePhase.icon == ""
        return ZStack(alignment: .center){
            //Change
            Button {
//                if !isItPassMealTime && !isCompleted{
                    isCameraClicked.toggle()
//                }
                
            } label: {
                Image(systemName: "camera.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(disable ? .inactiveIconTabBar : .gray)
                    .frame(width: 46, height: 36, alignment: .center)
            }
            .disabled(disable)
            
            if !isItPassMealTime && !isCompleted{
                Circle()
                    .stroke(style: .init(lineWidth: 4, dash: [30,1]))
                    .foregroundColor(.chatTopPinkColor)
                    .frame(width: 70)
                    .rotationEffect(animation ? Angle(degrees: 360.0) : .zero)
                    .animation(.linear(duration: 20).repeatForever(autoreverses: false), value: animation)
                    .onAppear {
                        animation.toggle()
                    }
//                    .rotationEffect()
            }
            
        }
        .onAppear{
            if !isItPassMealTime && !isCompleted {
                disable = false
            }
        }
    }
}

struct TakePitcureButton_Previews: PreviewProvider {
    static var previews: some View {
        TakePitcureButton(isCameraClicked: .constant(false), timePhase: .afternoon, isCompleted: false)
    }
}
