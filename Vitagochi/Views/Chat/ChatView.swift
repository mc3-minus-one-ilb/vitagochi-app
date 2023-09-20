//
//  ChatView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 19/07/23.
//

import SwiftUI
import WidgetKit

struct ChatView: View {
    @EnvironmentObject private var envObj: GlobalEnvirontment
    @EnvironmentObject private var coreDataEnv: CoreDataEnvirontment
    @StateObject private var chatVM: ChatViewModel
    
    init(initialMessage: Message, photoData: Data?, timePhase: VitaTimePhase) {
        let chatVM = ChatViewModel(
            initialMessage,
            photoData: photoData,
            timePhase: timePhase
        )
        
        self._chatVM = StateObject(wrappedValue: chatVM)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    envObj.mainPath[0].toggle()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 25))
                        .fontWeight(.regular)
                }
//                .padding(.trailing, 2)
                
                Image(chatVM.vitaIconImageName)
                    .resizable()
                    .background(Color.vitaProfileBackgroundColor)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Vita 🍎🥬")
                        .font(.body)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                    Text("Online")
                        .font(.system(.caption2, weight: .regular))
                        .fontDesign(.rounded)
                }
                Spacer()
            }
            .foregroundColor(.black)
            .padding()
            .padding(.top, 44)
            .background(Color.primaryWhite)
            .clipped()
            .shadow(color: Color.black.opacity(0.05),
                    radius: 8, x: 0, y: 4)
            
            Spacer()
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollViewReader { reader in
                        VStack(spacing: 20) {
                            ForEach(chatVM.messages) { message in
                                ChatBubble(isCompleted: $chatVM.isCompleted,
                                           message: message)
                            }
                            .onChange(of: chatVM.messages) { newValue in
                                if newValue.last!.isMyMessage {
                                    reader.scrollTo(newValue.last?.id)
                                }
                            }
                            
                        }
                        .padding([.horizontal, .bottom])
                        .padding(.top, 25)
                        .animation(.easeInOut, value: chatVM.messages)
                    }
                }
                
                HStack(spacing: 15) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        if chatVM.isMyOptionsActive {
                            HStack {
                                ForEach(chatVM.myOptionsMessages) { message in
                                    ChatBubble(isCompleted: $chatVM.isCompleted,
                                               message: message,
                                               isHorizontalScroll: true)
                                    .onTapGesture {
                                        chatVM.writeMessage(message)
                                        chatVM.isMyOptionsActive.toggle()
                                        chatVM.vitaAnswer = message.vitaAnswer!
                                        // Execute after 1.5 Second
                                        DispatchQueue.main
                                            .asyncAfter(deadline: .now() + 1.5) {
                                                let vitaMessage = Message(
                                                    id: Date(),
                                                    text: message.vitaAnswer!
                                                        .getAnswer(name: envObj.username),
                                                    isMyMessage: false,
                                                    profilPic: chatVM.vitaIconImageName,
                                                    vitaAnswer: message.vitaAnswer!)
                                                chatVM.writeMessage(vitaMessage)
                                            }
                                    }
                                }
                            }
                            .transition(.push(from: .bottom))
                        }
                    }
                    .padding(.vertical, 12)
                    .animation(.easeInOut, value: chatVM.isMyOptionsActive)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .clipShape(Rectangle())
            .navigationDestination(isPresented: $envObj.mainPath[1]) {
                LevelUpView()
            }
            .onChange(of: chatVM.isCompleted) { newValue in
                if newValue {
                    guard let photoName = chatVM
                        .savePhotoToFileManager() else {return}
                    
                    coreDataEnv
                        .addTodayMealRecord(name: envObj.username,
                                            mealStatus: chatVM.vitaAnswer,
                                            timeStatus: chatVM.timePhase,
                                            photoName: photoName)
                    
                    coreDataEnv.checkAndAddBadge(phase: chatVM.timePhase)
                    
                    weak var notificationHandler = NotificationHandler.singleton
                    notificationHandler?
                        .removeNotificationNotYet(timePhase: chatVM.timePhase)
                    
                    WidgetCenter.shared.reloadAllTimelines()
                    
                    let progress = coreDataEnv.levelProgress()
                    let tempVitaModel = coreDataEnv.vitaSkinModel
                    let level = tempVitaModel.rawValue + 1
                    coreDataEnv.getVitaModel()
                    
                    // TODO: 66 Days
                    if coreDataEnv.vitaSkinModel != tempVitaModel {
                        if level == 2 {
                            envObj.achievement = .level2
                        } else if level == 3 {
                            envObj.achievement = .level3
                        } else if level >= 4 {
                            envObj.achievement = .levelFinal
                        }
                        return
                    }
                    
                    if  !coreDataEnv.isAnotherTodayMealRecord() {
                        envObj.achievement = .firstMeal
                    } else {
                        envObj.achievement = .secondOrThirdMeal
                    }
                    
                    envObj.toggleChatViewNav()
                }
            }
            
        }
        .fontDesign(.rounded)
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.whiteGrayish)
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        //        ChatView(chatModel: ChatViewModel(photoData: Data()))
        let previewInitialMessage = Message(id: Date(),
                                            text: "Photo",
                                            isMyMessage: true,
                                            profilPic: "")
        
        ChatView(initialMessage: previewInitialMessage,
                 photoData: nil,
                 timePhase: .morning)
            .environmentObject(GlobalEnvirontment.singleton)
            .environmentObject(CoreDataEnvirontment.singleton)
    }
}
