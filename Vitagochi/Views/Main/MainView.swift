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
        let levelProgress = coreDataEnv.levelProgress()
        let level = coreDataEnv.vitaSkinModel.rawValue + 1
        let oneProgress = 34
        let countTodayProgress = coreDataEnv
            .todayChallenge?.records?.count ?? 0
        let initialMessage = Message(id: Date(),
                                     text: "",
                                     isMyMessage: true,
                                     profilPic: "",
                                     photo: mainVM.imageData)
        return VStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Hi, \(envObj.username)!")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    
                    HStack(spacing: 6) {
                        Text("It's")
                            .font(.system(.body, design: .rounded))
                        Text(mainVM.currentTime.getFormattedTime())
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.semibold)
                    }
                }
                .padding(.top, 24)
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
            .padding(.top, 34)
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
                    percentage: CGFloat((countTodayProgress) * oneProgress))
                .frame(width: 300, height: 300)
                .offset(y: -90)
                
                Ellipse()
                    .fill(Color.shadowEclipseColor)
                    .frame(width: 150, height: 40)
                    .offset(y: 15)
                
                showVitaModelCharacter()
                
                StatusLevelView(level: level,
                                exp: Int(levelProgress))
                .frame(width: 200, height: 10)
                .offset(y: 40)
            }
            .padding(.bottom, 34)
            .frame(height: 390)
            .scaleEffect(scaleSize)
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
            mainVM.generateMessage(
                for: coreDataEnv.todayChallenge,
                isFirstTime: envObj.isFisrtTime
            )
            
            mainVM.runTimerForCheckPhaseTime()
            
            WidgetCenter.shared.reloadAllTimelines()
            
        }
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
        .edgesIgnoringSafeArea([.top, .horizontal])
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
                .frame(width: 300, height: 116)
                .animation(.easeInOut, value: mainVM.vitaMessage)
            Image(mainVM.vitaSkinImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 222, height: 390)
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
        MainView()
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
