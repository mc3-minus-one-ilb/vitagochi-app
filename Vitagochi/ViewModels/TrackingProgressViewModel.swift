//
//  TrackingProgressViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

enum RectPosition: Int {
    case leading = 0
    case center = 1
    case trailing = 2
    
    var alignment: Alignment {
        switch self {
        case.leading:
            return Alignment.leading
        case.center:
            return Alignment.center
        case.trailing:
            return Alignment.trailing
        }
    }
}

class TrackingProgressViewModel: ObservableObject {
    
    @Published var daysCount: Int = 0
    @Published var selection: Int = 0
    @Published var rectPosition: RectPosition = .leading
    @Published var showingInformationSheet: Bool = false
    
    func changeRectPosition(value: Int) {
        withAnimation(.easeIn) {
            rectPosition = RectPosition(rawValue: value)!
        }
    }
}
