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
    @StateObject var chatModel = ChatViewModel(message: Message(id: Date(), text: "Photo", isMyMessage: true, profilPic: ""))
    @State var isCompleted: Bool = false
    var timePhase: VitachiTimePhase
    
    var body: some View {
        VStack{
            VStack() {
                Text("My Vita")
                    .font(.system(.title, weight: .semibold))
                    .fontDesign(.rounded)
            }
            .foregroundColor(.white)
            .padding()
            .padding(.top, 34)
            
            Spacer()
            
            VStack{
                ScrollView(.vertical,showsIndicators: false) {
                    ScrollViewReader{ reader in
                        VStack(spacing: 20) {
                            ForEach(chatModel.messages) { message in
                                ChatBubble(isCompleted: $isCompleted, message: message)
                            }
                            .onChange(of: chatModel.messages) { newValue in
                                if newValue.last!.isMyMessage {
                                    reader.scrollTo(newValue.last?.id)
                                }
                            }
                            
                        }
                        .padding([.horizontal, .bottom])
                        .padding(.top, 25)
                        .animation(.easeInOut, value: chatModel.messages)
                    }
                }
                
                HStack(spacing: 15) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        if chatModel.showMyOptions {
                            HStack {
                                ForEach(chatModel.myOptionsMessages) {
                                    message in
                                    ChatBubble(isCompleted: $isCompleted, message: message, isHorizontalScroll: true)
                                        .onTapGesture {
                                            chatModel.writeMessage(message)
                                            chatModel.showMyOptions.toggle()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                chatModel.writeMessage(Message(id: Date(), text: message.vitaAnswer!.answer(name: envObj.username), isMyMessage: false, profilPic: "VitaChatIcon", vitaAnswer: message.vitaAnswer!))
                                            }
                                        }
                                }
                            }
                            .transition(.push(from: .bottom))
                        }
                    }
                    .padding(.vertical, 12)
                    .animation(.easeInOut, value: chatModel.showMyOptions)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(Color.white)
            .clipShape(RoundedShape())
            .navigationDestination(isPresented: $envObj.mainPath[1]){
                LevelUpView()
            }
            .onChange(of: isCompleted) { newValue in
                // TODO: CHANGE
                if newValue {
                    guard let photoName = chatModel.savePhoto() else {return}
                    CoreDataEnvirontment.singleton.addMealRecordToTodayCallange(name:envObj.username,mealStatus: chatModel.vitaAnswer, timeStatus: timePhase, photoName: photoName)
                    
                    let notificationHandler = NotificationHandler.singleton
                    switch timePhase {
                    case .morning:
                        notificationHandler.removeNotificationById(identifier: ReminderType.BREAKFAST_NOT_YET.getString())
                    case .afternoon:
                        notificationHandler.removeNotificationById(identifier: ReminderType.LUNCH_NOT_YET.getString())
                    case .evening:
                        notificationHandler.removeNotificationById(identifier: ReminderType.DINNER_NOT_YET.getString())
                    case .beforeDayStart: break
                        
                    case .afterDay: break
                        
                    }
                    
                    print(notificationHandler.showScheduledNotifications())
                    
                    envObj.mainPath[1].toggle()
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.chatTopPinkColor)
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
       
    }
}



struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        //        ChatView(chatModel: ChatViewModel(photoData: Data()))
        ChatView(timePhase: .morning)
            .environmentObject(GlobalEnvirontment.singleton)
    }
}
