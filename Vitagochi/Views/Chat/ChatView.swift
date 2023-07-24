//
//  ChatView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 19/07/23.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject private var envObj: GlobalEnvirontment
    @StateObject var chatModel = ChatViewModel(message: Message(id: Date(), text: "Photo", isMyMessage: true, profilPic: ""))
    @State var isCompleted: Bool = false
    var timePhase: VitachiTimePhase
    var vitaChatIcon: String = "VitaChatIcon"
    
    var body: some View {
        VStack{
            HStack() {
                Button {
                    envObj.mainPath[0].toggle()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size:17))
                        .fontWeight(.semibold)
                }
                .padding(.trailing, 2)
                
                Image(vitaChatIcon)
                    .resizable()
                    .background(Color.vitaProfileBackgroundColor)
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text("My Vita 🍎🥬")
                        .font(.system(size:17, weight: .semibold))
                        .fontDesign(.rounded)
                    Text("Online")
                        .font(.system(.caption, weight: .semibold))
                        .fontDesign(.rounded)
                }
                Spacer()
            }
            .foregroundColor(.black)
            .padding()
            .padding(.top, 34)
            .background(Color.primaryWhite)
            .clipped()
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
            
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
                                                chatModel.writeMessage(Message(id: Date(), text: message.vitaAnswer!.answer(name: envObj.username), isMyMessage: false, profilPic: vitaChatIcon, vitaAnswer: message.vitaAnswer!))
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
            .clipShape(Rectangle())
            .navigationDestination(isPresented: $envObj.mainPath[1]){
                LevelUpView()
            }
            .onChange(of: isCompleted) { newValue in
                // TODO: CHANGE
                if newValue {
                    guard let photoName = chatModel.savePhoto() else {return}
                    CoreDataEnvirontment.singleton.addMealRecordToTodayCallange(name:envObj.username,mealStatus: chatModel.vitaAnswer, timeStatus: timePhase, photoName: photoName)
                envObj.mainPath[1].toggle()
                }
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.primaryWhite)
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
