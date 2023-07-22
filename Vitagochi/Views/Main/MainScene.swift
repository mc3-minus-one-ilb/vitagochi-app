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

//struct AdaptiveView<Content: View>: View {
//    var content: Content
//    init(@ViewBuilder content: @escaping ()-> Content) {
//        self.content = content()
//    }
//    
//    var body: some View {
//        ViewThatFits{
//            content
//
//            ScrollView(.vertical) {
//                content
//            }
//        }
//    }
//}

struct MainSceneView: View {
    @EnvironmentObject var coreDataEnv: CoreDataEnvirontment
    @EnvironmentObject private var envObj: GlobalEnvirontment
    @StateObject var vitaModel: MainSceneViewModel = MainSceneViewModel()
    @State var timer: Timer?
    @State var shouldNavigateToChat: Bool = false
    let scaleSize: Double
    
    init() {
        scaleSize = MainSceneView.ScaleContentBasedHeight()
    }
    
    var body: some View {
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
                    .padding(.top, 24)
                    Spacer()
                    if let records = coreDataEnv.todayChallange?.records?.allObjects as? [MealRecordEntity] {
                        TakePitcureButton(isCameraClicked: $vitaModel.isCameraClicked, timePhase: vitaModel.phase, isCompleted: records.contains{$0.timeStatus == vitaModel.phase.rawValue})
                    }
                }
                .padding()
                .padding(.horizontal, 8)
                .padding(.top, 34)
                Spacer()
                ZStack(alignment: .bottom){
                    GeometryReader { geo in
                        //Change Offset Problem
                        BackgroundArc()
                            .rotation(.degrees(180))
                            .foregroundColor(Color.backgrounCurveColor)
                            .offset(y: geo.size.height - 40)
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .bottom)
                            .padding(.bottom, 100)
                    }
                    
                    CircularProgressView(pulsate: true, percentage: CGFloat((coreDataEnv.todayChallange!.records!.count) * 34))
                        .frame(width: 300, height: 300)
                        .offset(y: -90)
                    
                    Ellipse()
                        .fill(Color.shadowEclipseColor)
                        .frame(width: 150, height: 40)
                        .offset(y:15)
                    //Change
                    VStack{
                        RectangleBubleTextView(text: vitaModel.message)
                            .frame(width: 300, height: 116)
                            .animation(.easeInOut, value: vitaModel.message)
                        Image(vitaModel.mood.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 222, height: 390)
                            .onTapGesture {
                                vitaModel.isTapped.toggle()
                                vitaModel.isCompleted[vitaModel.phase.completedIndex].toggle()
                            }
                        
                    }
                    StatusLevelView(level: 1, exp: 2)
                        .frame(width: 170, height: 8)
                        .offset(y:36)
                }
                .frame(height: 390)
                .scaleEffect(scaleSize)
                Spacer()
                Spacer()
//                ChatView(chatModel: ChatViewModel(photoData: vitaModel.imageData)\
            }
            .background(Image("Background"))
            .onChange(of: vitaModel.phase) { _ in
                vitaModel.GenerateMessage(for: coreDataEnv.todayChallange!)
            }
            .onChange(of: vitaModel.isTapped) { _ in
                vitaModel.GenerateMessage(for: coreDataEnv.todayChallange!)
            }
            .onChange(of: vitaModel.isCompleted) { _ in
                vitaModel.GenerateMessage(for: coreDataEnv.todayChallange!)
            }
            .onChange(of: vitaModel.imageData, perform: { _ in
                envObj.mainPath[0].toggle()
            })
            .onAppear {
                vitaModel.GenerateMessage(for: coreDataEnv.todayChallange!)
            }
            .navigationDestination(isPresented: $envObj.mainPath[0]) {
                 ChatView(chatModel: ChatViewModel(message: Message(id: Date(), text: "", isMyMessage: true, profilPic: "", photo: vitaModel.imageData), photoData: vitaModel.imageData), timePhase: vitaModel.phase)
            }
            .fullScreenCover(isPresented: $vitaModel.isCameraClicked) {
                PhotoTakeView(showPicker: $vitaModel.isCameraClicked, imageData: $vitaModel.imageData)
                    .gesture(swipeDownGesture)
                    .ignoresSafeArea()
                
            }
            .ignoresSafeArea()
    }
    
    static func ScaleContentBasedHeight() -> Double {
        let heightScreen = UIScreen.main.bounds.height
        
        if heightScreen >= 932 {
            return 1.15
        } else if heightScreen >= 852 {
            return 1.05
        } else {
            return 1
        }
    }
    
    var swipeDownGesture: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.height > 0 {
                    vitaModel.isCameraClicked = false
                }
            }
    }
}

struct MainSceneView_Previews: PreviewProvider {
    static var previews: some View {
        MainSceneView()
            .environmentObject(GlobalEnvirontment.singleton)
            .environmentObject(CoreDataEnvirontment.singleton)
        //        MainSceneView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
        //            .previewDisplayName("iPhone 14 Pro Max")
        //
        //        MainSceneView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
        //            .previewDisplayName("iPhone 14 Pro")
        //
        //        // MARK: Need Fix
        //        MainSceneView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        //            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
