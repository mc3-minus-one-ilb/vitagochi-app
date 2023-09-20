//
//  MainSceneView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI
import WidgetKit

struct MainView: View {
    @EnvironmentObject private var coreDataEnv: CoreDataEnvirontment
    @EnvironmentObject private var envObj: GlobalEnvirontment
    @StateObject private var mainVM: MainViewModel
    @State private var tutorialPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    let scaleSize: Double
    
    init() {
        weak var coreData = CoreDataEnvirontment.singleton
        let vitaSkin: VitaSkinModel = coreData?
            .vitaSkinModel ?? .casual
        let vitaMood: VitaMoodPhase = (coreData?
            .checkYesterdayHasNoRecord() ?? false) ? .sick : .idle
        
        self._mainVM = StateObject(
            wrappedValue: MainViewModel(vitaSkin: vitaSkin,
                                        vitaMood: vitaMood))
        
        scaleSize = MainView.scaleContentBasedHeight()
    }
    
    var body: some View {
        
        let level = coreDataEnv.vitaSkinModel.rawValue + 1
        let oneProgress = 34
        let initialMessage = Message(id: Date(),
                                     text: "",
                                     isMyMessage: true,
                                     profilPic: "",
                                     photo: mainVM.imageData)
        return GeometryReader { geo in
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Hi, \(envObj.username)!")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.semibold)
                        
                        Text("It's a new day")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)
                    }
                    //
                    Spacer()
                    if let records = coreDataEnv
                        .todayChallenge?.records?.allObjects as? [MealRecordEntity] {
                        let isCompleted = records
                            .contains {$0.timeStatus == mainVM.vitaPhase.rawValue}
                        TakePitcureButton(
                            isCameraClicked: $mainVM.isCameraClicked,
                            timePhase: mainVM.vitaPhase,
                            isCompleted: isCompleted
                        )
                    } else {
                        TakePitcureButton(
                            isCameraClicked: $mainVM.isCameraClicked,
                            timePhase: mainVM.vitaPhase,
                            isCompleted: false
                        )
                    }
                }
                .padding()
                .padding(.horizontal, 8)
                .padding(.top, 54)
                .background {
//                                    Color.black.opacity(0.3)
//                                        .edgesIgnoringSafeArea([.top, .horizontal])
//                                        .zIndex(0)
                }
                
                Spacer()
                
                
                ZStack(alignment: .bottom) {
                    
                    GeometryReader { geo in
                        BackgroundArc()
                            .rotation(.degrees(180))
                            .foregroundColor(Color.backgrounCurveColor)
                            .offset(y: geo.size.height - 40)
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height,
                                alignment: .bottom
                            )
                            .padding(.bottom, 100)
                    }
                    
                    CircularProgressView(
                        pulsate: false,
                        percentage: CGFloat((mainVM.todayProgress) * oneProgress),
                        whiteBackgroundColor: true,
                        whiteOutlineColor: true)
                    .frame(width: 305, height: 305)
                    .offset(y: -85)
//                    .zIndex(1)
                  
                    Ellipse()
                        .fill(Color.mintAccent3)
                        .frame(width: 99, height: 28)
                        .offset(y: 7)
                    
                    showVitaModelCharacter()
//                        .zIndex(1)
                    
                    StatusLevelView(level: level,
                                    exp: Int(mainVM.levelProgress))
//                    .zIndex(1)
                    
                    
                    .frame(width: 200, height: 10)
                    .offset(y: 30)
                    
//                                    Color.black.opacity(0.3)
//                                        .edgesIgnoringSafeArea([.top, .horizontal])
//                                        .zIndex(0)
//                                    Color.black.opacity(0.3)
//                                        .edgesIgnoringSafeArea([.top, .horizontal])
//                                        .frame(maxWidth: .infinity, maxHeight: 150)
//                                        .offset(y: 150)
//                                        .zIndex(0)
                }
                .padding(.bottom, 34)
                .frame(height: 390)
                
                .scaleEffect(scaleSize)
//                .offset(y:-60)
                Spacer()
                Spacer()
            }
            
            .onChange(of: mainVM.vitaPhase) { _ in
                mainVM.generateMessage(for: coreDataEnv.todayChallenge)
            }
            .onChange(of: mainVM.isTapped) { _ in
                mainVM.generateMessage(for: coreDataEnv.todayChallenge)
            }
            .onChange(of: mainVM.vitaMood, perform: { _ in
                mainVM.runAnimation()
            })
            .onChange(of: mainVM.imageData, perform: { _ in
                envObj.toggleChatViewNav()
            })
            .onAppear {
                if envObj.achievement != nil {
                    mainVM.todayProgress = 0
                    mainVM.levelProgress = 0
                } else  {
                    mainVM.todayProgress = coreDataEnv
                        .todayChallenge?.records?.count ?? 0
                    mainVM.levelProgress = coreDataEnv.levelProgress()
                }
                
                mainVM.generateMessage(
                    for: coreDataEnv.todayChallenge,
                    isFirstTime: envObj.isFisrtTime
                )
                
                mainVM.runTimerForCheckPhaseTime()
                
                WidgetCenter.shared.reloadAllTimelines()
                
            }
            .onChange(of: envObj.achievement, perform: { newValue in
                mainVM.todayProgress = 0
                mainVM.levelProgress = 0
                if newValue == nil {
                    withAnimation(.easeOut(duration: 1.0)) {
                        mainVM.todayProgress = coreDataEnv
                            .todayChallenge?.records?.count ?? 0
                        mainVM.levelProgress = coreDataEnv.levelProgress()
                    }
                }
            })
            .navigationDestination(isPresented: $envObj.mainPath[0]) {
                ChatView(initialMessage: initialMessage,
                         photoData: mainVM.imageData,
                         timePhase: mainVM.vitaPhase)
            }
            .fullScreenCover(isPresented: $mainVM.isCameraClicked) {
                PhotoTakeView(
                    showPicker: $mainVM.isCameraClicked,
                    imageData: $mainVM.imageData
                )
                .gesture(swipeDownGesture)
                .ignoresSafeArea()
                
            }
           
            if mainVM.isShowTutorial {
//                Color.black.opacity(0.3)
//                    .edgesIgnoringSafeArea(.all)
            }
            
            if mainVM.isShowTutorial {
                TutorialView(isCompleted: $mainVM.isShowTutorial, stepNumber: $mainVM.tutorialStep)
                    .frame(width: 236)
                    .position(x: tutorialPosition.x, y: tutorialPosition.y)
                    .onAppear {
                        tutorialPosition = CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).height * 0.22)
                    }
                    .onChange(of: mainVM.tutorialStep) { new in
                        withAnimation(.spring()) {
                            if mainVM.tutorialStep == 1 {
                                tutorialPosition = CGPoint(x: geo.frame(in: .global).width * 0.43, y: geo.frame(in: .global).height * 0.25)
                            } else if mainVM.tutorialStep ==  2 {
                                tutorialPosition = CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).height * 0.22)
                            } else if mainVM.tutorialStep == 3 {
                                tutorialPosition = CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).height * 0.70)
                            }
                        }
                    }
            }
        }
    }
    
    static func scaleContentBasedHeight() -> Double {
        let heightScreen = UIScreen.main.bounds.height
        
        if heightScreen >= 932 {
            return 1.15
        } else if heightScreen >= 852 {
            return 1.05
        } else {
            return 1
        }
    }
    
    func showVitaModelCharacter() -> some View {
        VStack {
            RectangleBubleTextView(text: mainVM.vitaMessage.text)
                .frame(width: 256, height: 116)
                .animation(.easeInOut, value: mainVM.vitaMessage)
            Image(mainVM.vitaSkinImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 222, height: 400)
                .scaleEffect(1.08)
                .onTapGesture {
                    mainVM.vitaIsTapped()
                }
            
        }
    }
    
    var swipeDownGesture: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.height > 0 {
                    mainVM.isCameraClicked = false
                }
            }
    }
    
}

struct MainSceneView_Previews: PreviewProvider {
    static var previews: some View {
        let coreDataManager = CoreDataManager(.inMemory)
        let coreDataRepository = CoreDataRepository(manager: coreDataManager)
        let coreDataEnv = CoreDataEnvirontment(repository: coreDataRepository)
        
        return RootView()
            .environmentObject(GlobalEnvirontment.singleton)
            .environmentObject(coreDataEnv)
//        MainView()
//            .environmentObject(GlobalEnvirontment.singleton)
//            .environmentObject(CoreDataEnvirontment.singleton)
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
