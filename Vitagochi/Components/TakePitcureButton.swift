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
                if !isItPassMealTime && !isCompleted{
                    isCameraClicked.toggle()
                }
                
            } label: {
                Image(systemName: "camera.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(!isItPassMealTime && !isCompleted ? .pictureColor : .inactiveIconTabBar )
                    .frame(width: 46, height: 36, alignment: .center)
            }
            .overlay(alignment: .bottomTrailing) {
                if !isItPassMealTime && !isCompleted{
                    ZStack{
                        Circle()
                            .foregroundColor(.chatTopPinkColor)
                            .frame(width: 19, height: 19)
                        Circle()
                        
                            .stroke(style: .init(lineWidth: 2, dash: [8,8]))
                            .foregroundColor(.chatTopPinkColor)
                            .frame(width: 80)
                            .rotationEffect(animation ? Angle(degrees: 360.0) : .zero)
                            .animation(.linear(duration: 20).repeatForever(autoreverses: true), value: animation)
                            .onAppear {
                                animation.toggle()
                            }
                    }
                    .offset(x:-6, y:15)
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
        TakePitcureButton(isCameraClicked: .constant(false), timePhase: .afternoon, isCompleted: false)
    }
}
