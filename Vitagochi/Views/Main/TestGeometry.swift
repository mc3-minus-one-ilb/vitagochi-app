//
//  TestGeometry.swift
//  Vitagochi
//
//  Created by Enzu Ao on 06/09/23.
//

import SwiftUI

struct TestGeometry: View {
    
    @Namespace var namespace
    @State var tapped = false
    
    var body: some View {
        VStack {
            if !tapped {
                VStack {
                    Spacer()
                        .frame(height: 144)
                    Text("Hello")
                        .padding(44)
                        .background(Color.blue)
                        .matchedGeometryEffect(id: "kotak", in: namespace)
                }
            }
            else {
                VStack {
                    Text("Hello")
                        .padding(44)
                        .background(Color.red)
                        .matchedGeometryEffect(id: "kotak", in: namespace)
                    Spacer()
                        .frame(height: 444)
                }
               
            }
        }
        .onTapGesture {
            withAnimation(.spring()) {
                tapped.toggle()
            }
        }
    }
}

struct TestGeometry_Previews: PreviewProvider {
    static var previews: some View {
        TestGeometry()
    }
}
