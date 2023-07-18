//
//  Color+Hex.swift
//  Vitagochi
//
//  Created by Dzulfikar on 17/07/23.
//

import Foundation
import SwiftUI
import UIKit

extension Color {
    public static func toHex(hexCode: String) -> Color {
        return Color(uiColor: UIColor(hexCode))
    }
}
