//
//  ChatBubbleView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 19/07/23.
//

import SwiftUI

struct ChatBubble: View {
    @Binding var isCompleted: Bool
    var message: Message
    var isHorizontalScroll: Bool = false
    
    
    var body: some View {
        var uiImagePhoto = UIImage()
        var photoWidth = CGFloat()
        var photoHeight = CGFloat()
        if message.photo != nil {
            uiImagePhoto = UIImage(data: message.photo!)!
            photoWidth = uiImagePhoto.size.width
            photoHeight = uiImagePhoto.size.height
        }
        
        return HStack(alignment: .bottom, spacing: 35) {
            if message.isMyMessage {
                if !isHorizontalScroll {
                    Spacer(minLength: 25)
                }
                
                if message.photo == nil {
                    Text(message.text)
                        .font(.system(.subheadline, weight: isHorizontalScroll ? .semibold : .regular))
                        .kerning(-0.8)
                        .padding(.all, 16)
                        .foregroundColor(isHorizontalScroll ? Color.mintDark : Color.blackGreen)
                        .background(isHorizontalScroll ? Color.whiteGrayish : Color.whiteFull)
                        .overlay(content: {
                            if isHorizontalScroll {
                                BubbleArrow(isMyMessage: message.isMyMessage)
                                    .stroke(Color.mintDark, lineWidth: 2)
                            }
                        })
                        
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                        
                        .shadow(color: .black.opacity(0.02),
                                radius: 8, x: 2, y: 4)
                        
                } else {
                    Image(uiImage: uiImagePhoto)
                        .resizable()
                        .frame(width: photoWidth > photoHeight ?
                               UIScreen.main.bounds.width - 150 : 182,
                               height: photoWidth > photoHeight ? 180 : 220)
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                }
                
                //                Image(message.profilPic)
                //                    .resizable()
                //                    .frame(width: 30, height: 30)
                //                    .clipShape(Circle())
            } else {
//                Image(message.profilPic)
//                    .resizable()
//                    .background(Color.vitaProfileBackgroundColor)
//                    .frame(width: 52, height: 52)
//                    .clipShape(Circle())
//
                if message.photo ==  nil {
                    if message.vitaAnswer != nil {
                        VStack {
                            Text(message.text)
                                .font(.system(.subheadline, weight: .regular))
                                .kerning(-0.8)
                                .foregroundColor(.blackGreen)
                                .padding(.bottom, 12)
                         
                            Divider()
                                .padding(.top, 1)
                            //                            .fontWidth(22)
                                .background(Color.white)
                            Button {
                                isCompleted.toggle()
                            } label: {
                                Text(message.vitaAnswer!.labelConfirmation)
                                    .font(.system(.headline, weight: .bold))
                                    .fontDesign(.rounded)
                                    .foregroundColor(.mintDark)
                                    .kerning(-0.8)
                                    .padding(.top, 16)
                                    .padding(.bottom, 12)
                            }
                        }
                        .padding(.all, 16)
                        .background(Color.whiteFull)
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                        .shadow(color: .black.opacity(0.02),radius: 8, x: 2, y: 4)
                    } else {
                        Text(message.text)
                            .font(.system(.subheadline, weight: .regular))
                            .kerning(-0.8)
                            .foregroundColor(.blackGreen)
                            .padding(.all)
                            .background(Color.whiteFull)
                            .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                            .shadow(color: .black.opacity(0.02),
                                    radius: 8, x: 2, y: 4)
                    }

                } else {
                    Image(uiImage: UIImage(data: message.photo!)!)
                        .resizable()
                        .frame(width: photoWidth > photoHeight ?
                               UIScreen.main.bounds.width - 150 : 182,
                               height: photoWidth > photoHeight ? 150 : 220)
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                }
                
                Spacer(minLength: 40)
            }
        }
        .id(message.id)
        .transition(.push(from: .bottom))
    }
}

struct ChatBuble_Previews: PreviewProvider {
    static var previews: some View {
        //        ChatView(chatModel: ChatViewModel(photoData: Data()))
        let initialMessagePreview = Message(id: Date(),
                                            text: "Photo",
                                            isMyMessage: true,
                                            profilPic: "")
        
        ChatView(initialMessage: initialMessagePreview,
                 photoData: nil,
                 timePhase: .morning)
            .environmentObject(GlobalEnvirontment.singleton)
            .environmentObject(CoreDataEnvirontment.singleton)
    }
}
