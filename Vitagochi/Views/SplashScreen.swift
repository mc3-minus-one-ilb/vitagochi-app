//
//  SplashScreen.swift
//  Vitagochi
//
//  Created by Dzulfikar on 24/07/23.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("SplashScreenText")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("SplashScreenBackground").resizable())
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        SplashScreen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")

    }
}
