//
//  CounterTextFieldStyle.swift
//  Vitagochi
//
//  Created by Dzulfikar on 12/07/23.
//

import SwiftUI
import Combine

struct CounterTextFieldStyle: TextFieldStyle {
    @Binding var input: String
    @State var maxLength: Int = 0

    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            Group {
                configuration
                    .body
                    .onReceive(Just(input), perform: { newInput in
                        input = String(newInput.prefix(maxLength))
                    })
                Text("\(input.count)/\(maxLength)")
                    .foregroundColor(.labelColor)
                    .opacity(0.5)
            }
            .padding(.bottom, 8.0)
        }
        .overlay(Rectangle()
            .frame(width: nil, height: 1, alignment: .bottom)
            .foregroundColor(.labelColor).opacity(input.count > 0 ? 1.0 : 0.5), alignment: .bottom)
    }
}
