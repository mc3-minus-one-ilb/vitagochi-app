//
//  Color+Extend.swift
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
    public static let gray1: Color = Color(0x838383)
    public static let blackBase: Color = Color(0x272727)
    public static let bubleTextBackgroundColor: Color = Color(0xED476B)
    public static let mintPrimary: Color = Color(0x47EDC9)
    public static let circularProgressBackground: Color = Color(0xC2F9ED)
    public static let circularProgressPulsating: Color = Color(0x47EDC9)
    public static let backgrounCurveColor: Color = Color(0xC2F9ED)
    public static let activeIconTabBar: Color = Color(0x838383)
    public static let inactiveIconTabBar: Color = Color(0xD3D3D3)
    public static let chatTopPinkColor: Color = Color(0xED476B)
    public static let vitaProfileBackgroundColor: Color = Color(0xFBDAE1)
    public static let backgroundBadge: Color = Color(0xC3FAEE)
    public static let widgetFontColor: Color = Color(0x184F43)
    public static let blackGreen: Color = Color(0x0E2F28)
    public static let mintDark: Color = Color(0x2F9E86)
    public static let pinkAccent: Color = Color(0xF6A3B5)
    public static let yellowAccent2: Color = Color(0xF3EE84)
    public static let mintAccent2: Color = Color(0x84F3DB)
    public static let mintAccent3: Color = Color(0xDAFBF4)
    public static let yellowAccent1: Color = Color(0xEDE647)
    public static let gray3: Color = Color(0xECECEC)
    public static let gray2: Color = Color(0xCBCBCB)
    public static let whiteGrayish: Color = Color(0xFAFBFB)
    public static let whiteFull: Color = Color(0xFFFFFF)
    public static let BlackUnsignificant: Color = Color(0x585858)
}
