//
//  PrimaryButton.swift
//  Vitagochi
//
//  Created by Dzulfikar on 12/07/23.
//

import SwiftUI

struct PrimaryButton: View {
    var action: () -> ()
    var input: String
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(input)
                .frame(maxWidth: .infinity)
                .padding(8.0)
                .foregroundColor(.black)
                .fontWeight(.semibold)
        }
        .buttonStyle(.borderedProminent)
        .tint(.primaryColor)
        
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    
    static var previews: some View {
        PrimaryButton(action: {
            
        }, input: "ACTION!")
    }
}
