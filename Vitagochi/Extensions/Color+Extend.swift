//
//  Color+Hex.swift
//  Vitagochi
//
//  Created by Dzulfikar on 11/07/23.
//

import Foundation
import SwiftUI

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
          .sRGB,
          red: Double((hex >> 16) & 0xFF) / 255,
          green: Double((hex >> 8) & 0xFF) / 255,
          blue: Double(hex & 0xFF) / 255,
          opacity: alpha
        )
      }
    
    public static let primaryColor: Color = Color("PrimaryColor")
    public static let secondaryColor: Color = Color("SecondaryColor")
    public static let primaryWhite: Color = Color("PrimaryWhiteColor")
    public static let primaryBlack: Color = Color("PrimaryBlackColor")
    public static let labelColor: Color = Color("LabelColor")
//    public static let imageIconColor: Color = Color(hex: 838383)
//    public static let titleTextColor: Color = Color(hex: 272727)
    public static let bubleTextBackgroundColor: Color = Color(0xED476B)
    public static let circularProgressOutline: Color = Color(0x47EDC9)
    public static let circularProgressBackground: Color = Color(0xC2F9ED)
    public static let circularProgressTrack: Color = Color(0xDAFBF4)
    public static let circularProgressPulsating: Color = Color(0x47EDC9)
    public static let backgrounCurveColor: Color = Color(0xC2F9ED)
    public static let shadowEclipseColor: Color = Color(0xDAFBF4)
    public static let activeIconTabBar: Color = Color(0x838383)
    public static let inActiveIconTabBar: Color = Color(0xD3D3D3)
    public static let chatTopPinkColor: Color = Color(0xED476B)
}
