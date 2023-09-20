//
//  CounteredTextView.swift
//  Vitagochi
//
//  Created by Dzulfikar on 12/07/23.
//

import SwiftUI

struct CounteredTextView: View {
    @Binding var input: String
    var body: some View {
        TextField("", text: $input, prompt: Text("Type your nickname").font(.title3).fontWeight(.regular))
            .textFieldStyle(CounterTextFieldStyle(input: $input, maxLength: 10))
            .autocorrectionDisabled()
    }
}

struct CounteredTextView_Previews: PreviewProvider {
    static var previews: some View {
        CounteredTextView(input: .constant("ASD"))
    }
}
