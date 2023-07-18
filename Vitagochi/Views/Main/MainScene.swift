//
//  MainSceneView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

struct BackgroundArc: Shape {
    var yOffset: CGFloat = -50
    
    var animatableData: CGFloat {
        get { return yOffset }
        set { yOffset = newValue}
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - yOffset))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY - yOffset), control: CGPoint(x: rect.midX, y: rect.maxY + yOffset))
        path.closeSubpath()
        
        return path
    }
}

struct MainSceneView: View {
    @State var messageIndex: [String] = ["Welcome! \nTap me so I can speak to you", "hello"]
    @State var isClicked: Bool = false
    var body: some View {
            GeometryReader { geo in
                
                VStack{
                    HStack{
                        VStack(alignment: .leading, spacing: 6){
                            //Change
                            Text("Hi, Haris!")
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.bold)
                            
                            HStack(spacing: 6){
                                Text("It's")
                                    .font(.system(.body, design: .rounded))
                                //Change
                                Text("06.00 am")
                                    .font(.system(.headline, design: .rounded))
                                    .fontWeight(.semibold)
                            }
                        }
                        Spacer()
                        ZStack(alignment: .bottomLeading){
                            //Change
                            Image(systemName: "camera.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(width: 46, height: 36, alignment: .center)
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 19)
                                .overlay {
                                    //Change
                                    Text("3")
                                        .font(.system(.caption2, design: .rounded))
                                        .foregroundColor(.white)
                                }
                                .offset(x:-8,y: 8)
                            
                        }
                    }
                    .padding()
                    .padding(.horizontal, 8)
                    Spacer()
                    ZStack(alignment: .center){
                        GeometryReader { geo in
                            //Change Offset Problem
                            BackgroundArc()
                                .rotation(.degrees(180))
                                .foregroundColor(Color.backgrounCurveColor)
                                .offset(y: geo.size.height - 120)
                                .frame(width: geo.size.width, height: geo.size.height, alignment: .bottom)
                        }
                        //Change Offset Problem
                        CircularProgressView(percentage: 33)
                            .frame(width: 322, height: 322)
                            .offset(y: -25)
                        VStack(spacing: 0){
                            //Change
                            RectangleBubleTextView(text: messageIndex[isClicked ? 1 : 0])
                            
                            ZStack(alignment: .bottom){
                                Ellipse()
                                    .fill(Color.shadowEclipseColor)
                                    .frame(width: 150, height: 40)
                                    .offset(y:15)
                                //Change
                                Image("MainVitaIdle")
                                    .resizable()
                                    .frame(width: 222, height: 420)
                                    .onTapGesture {
                                        isClicked.toggle()
                                    }
                                
                            }
                            //Change
                            StatusLevelView(level: 1, exp: 2)
                                .frame(width: 170, height: 8)
                                .offset(y:30)
                            
                            Spacer()
                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //            .padding(.top, 30)
                    
                }
                .background(Color.primaryWhite)
            }
    }
}

struct MainSceneView_Previews: PreviewProvider {
    static var previews: some View {
        MainSceneView()
    }
}