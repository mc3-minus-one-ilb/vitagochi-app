//
//  MainSceneView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

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
    
    let scaleSize: Double
    
    init() {
        scaleSize = MainSceneView.ScaleContentBasedHeight()
    }
    
    var body: some View {
        let progress = coreDataEnv.levelProgress()
            return VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 6){
                        //Change
                        Text("Hi, \(envObj.username)!")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                        
                        HStack(spacing: 6){
                            Text("It's")
                                .font(.system(.body, design: .rounded))
                            //Change
                            Text(vitaModel.currentTime.getFormattedTime())
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.top, 24)
                    Spacer()
                    if let records = coreDataEnv.todayChallange?.records?.allObjects as? [MealRecordEntity] {
                        TakePitcureButton(isCameraClicked: $vitaModel.isCameraClicked, timePhase: vitaModel.phase, isCompleted: records.contains{$0.timeStatus == vitaModel.phase.rawValue})
                    } else {
                        TakePitcureButton(isCameraClicked: $vitaModel.isCameraClicked, timePhase: vitaModel.phase, isCompleted: false)
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
                    
                    CircularProgressView(pulsate: false, percentage: CGFloat((coreDataEnv.todayChallange?.records?.count ?? 0) * 34))
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
                        Image(vitaModel.skin)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 222, height: 390)
                            .scaleEffect(1.08)
                            .onTapGesture {
                                vitaModel.isTapped.toggle()
                                vitaModel.isCompleted[vitaModel.phase.completedIndex].toggle()
                            }
                        
                    }
                    StatusLevelView(level: coreDataEnv.vitaSkinModel.rawValue + 1, exp: Int(progress))
                        .frame(width: 200, height: 10)
                        .offset(y:40)
                }
                .padding(.bottom, 34)
                .frame(height: 390)
                .scaleEffect(scaleSize)
                Spacer()
                Spacer()
//                ChatView(chatModel: ChatViewModel(photoData: vitaModel.imageData)\
            }
            
            .onChange(of: vitaModel.phase) { _ in
                vitaModel.GenerateMessage(for: coreDataEnv.todayChallange)
            }
            .onChange(of: vitaModel.isTapped) { _ in
                vitaModel.GenerateMessage(for: coreDataEnv.todayChallange)
            }
            .onChange(of: vitaModel.isCompleted) { _ in
                vitaModel.GenerateMessage(for: coreDataEnv.todayChallange)
            }
            .onChange(of: vitaModel.mood, perform: { _ in
                vitaModel.runAnimation()
            })
            .onChange(of: vitaModel.imageData, perform: { _ in
                envObj.mainPath[0].toggle()
            })
            .onAppear {
                vitaModel.GenerateMessage(for: coreDataEnv.todayChallange, isFirstTime: envObj.isFisrtTime)
                
                vitaModel.timer?.invalidate()
                vitaModel.timer = nil
                
                vitaModel.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    vitaModel.CheckPhaseTime()
                    vitaModel.currentTime = Date()
                }
            }
            .navigationDestination(isPresented: $envObj.mainPath[0]) {
                 ChatView(chatModel: ChatViewModel(message: Message(id: Date(), text: "", isMyMessage: true, profilPic: "", photo: vitaModel.imageData), photoData: vitaModel.imageData), timePhase: vitaModel.phase)
            }
            .fullScreenCover(isPresented: $vitaModel.isCameraClicked) {
                PhotoTakeView(showPicker: $vitaModel.isCameraClicked, imageData: $vitaModel.imageData)
                    .gesture(swipeDownGesture)
                    .ignoresSafeArea()
                
            }
            .edgesIgnoringSafeArea([.top,.horizontal])
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
