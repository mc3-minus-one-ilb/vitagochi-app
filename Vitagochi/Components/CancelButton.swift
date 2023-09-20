//
//  CancelButton.swift
//  Vitagochi
//
//  Created by Dzulfikar on 12/07/23.
//

import SwiftUI

struct CancelButton: View {
    var action: () -> Void
    var input: String
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(input)
                .fontWeight(.thin)
                .frame(maxWidth: .infinity)
                .padding(8.0)
        }
        .foregroundColor(.BlackUnsignificant)
    }
}

struct CancelButton_Previews: PreviewProvider {
    static var previews: some View {
        CancelButton(action: {
            
        }, input: "Wait ... go back please")
    }
}
