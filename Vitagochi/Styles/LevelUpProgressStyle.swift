//
//  LevelUpProgressStyle.swift
//  Vitagochi
//
//  Created by Dzulfikar on 20/07/23.
//

import Foundation
import SwiftUI

struct LevelProgressBar: View {
    var progress: CGFloat
    var height: CGFloat
    var geometry: GeometryProxy
    var body: some View {
        RoundedRectangle(cornerRadius: 20.0)
            .fill(.white)
            .frame(height: height)
            .frame(width: geometry.size.width)
            .overlay(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(
                        LinearGradient(
                            gradient:
                                Gradient(colors: [Color.toHex(hexCode: "F6A3B5"),
                                                  Color.toHex(hexCode: "F06684"),
                                                  Color.toHex(hexCode: "ED476B")]),
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
                    .frame(width: geometry.size.width * progress)
            }
    }
}

struct LevelUpProgressStyle: ProgressViewStyle {
    var color = Color.toHex(hexCode: "ED476B")
    var height = 16.0
    var labelFontStyle: Font = .body
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            
            VStack(alignment: .leading) {
                
                LevelProgressBar(progress: progress, height: height, geometry: geometry)
                
                HStack {
                    configuration.label
                        .font(labelFontStyle)
                        .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if let currentValueLabel = configuration.currentValueLabel {
                        currentValueLabel
                            .fontDesign(.rounded)
                    }
                }
            }
        }
    }
}

struct MainSceneLevelUpProgressStyle: ProgressViewStyle {
    var color = Color.toHex(hexCode: "ED476B")
    var height = 16.0
    var labelFontStyle: Font = .subheadline
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        HStack(alignment: .center, spacing: 10) {
            configuration.label
                .font(labelFontStyle)
                .fontWeight(.regular)
                .fontDesign(.rounded)
            
            GeometryReader { geometry in
                LevelProgressBar(progress: progress, height: height, geometry: geometry)
            }
            
            if let currentValueLabel = configuration.currentValueLabel {
                currentValueLabel
                    .font(labelFontStyle)
                    .fontWeight(.regular)
                    .fontDesign(.rounded)
            }
        }
        
    }
}

struct WidgetSmallMealProgressStyle: ProgressViewStyle {
    var color = Color.toHex(hexCode: "ED476B")
    var height = 16.0
    var labelFontStyle: Font = .body
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            
            VStack(alignment: .leading) {
                
                LevelProgressBar(progress: progress, height: height, geometry: geometry)
                
                HStack {
                    configuration.label
                        .font(labelFontStyle)
                        .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if let currentValueLabel = configuration.currentValueLabel {
                        currentValueLabel
                            .fontDesign(.rounded)
                    }
                    
                }
                
            }
            
        }
    }
}

struct WidgetMediumMealProgressStyle: ProgressViewStyle {
    var color = Color.toHex(hexCode: "ED476B")
    var height = 16.0
    var labelFontStyle: Font = .body
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            
            VStack(alignment: .leading) {
                
                HStack {
                    configuration.label
                        .font(labelFontStyle)
                        .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if let currentValueLabel = configuration.currentValueLabel {
                        currentValueLabel
                            .fontDesign(.rounded)
                    }
                    
                }
                .offset(y: 4)
                
                LevelProgressBar(progress: progress, height: height, geometry: geometry)
            }
            
        }
    }
}
