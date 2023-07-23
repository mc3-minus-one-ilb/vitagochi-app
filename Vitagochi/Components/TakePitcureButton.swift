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
    var timePhase: VitachiTimePhase
    var isCompleted: Bool
    
    
    var body: some View {
        let isItPassMealTime = timePhase.icon == ""
        return ZStack(alignment: .bottomLeading){
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
                    .foregroundColor(.bubleTextBackgroundColor)
                    .frame(width: 19)
                    .overlay {
                        //Change
                        // TODO: Change
                        Image(systemName: timePhase.icon)
                            .font(.system(size:9))
                            .foregroundColor(.white)
                    }
                    .offset(x:-8,y: 8)
            }
            
        }
        .onAppear{
            if !isItPassMealTime && !isCompleted {
                disable.toggle()
            }
        }
    }
}

struct TakePitcureButton_Previews: PreviewProvider {
    static var previews: some View {
        TakePitcureButton(isCameraClicked: .constant(false), timePhase: .morning, isCompleted: true)
    }
}
