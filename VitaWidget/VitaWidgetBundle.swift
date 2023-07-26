//
//  VitaWidgetBundle.swift
//  VitaWidget
//
//  Created by Pahala Sihombing on 18/07/23.
//

import WidgetKit
import SwiftUI

@main
struct VitaWidgetBundle: WidgetBundle {
    var body: some Widget {
        VitaWidget()
        VitaWidgetLiveActivity()
    }
}
