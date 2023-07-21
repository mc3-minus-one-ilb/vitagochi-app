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
        
        return HStack(alignment: .bottom, spacing: 10) {
            if message.isMyMessage {
                if !isHorizontalScroll{
                    Spacer(minLength: 25)
                }
                
                if message.photo == nil {
                    Text(message.text)
                        .font(.system(.subheadline, weight: .regular))
                        .kerning(-0.4)
                        .padding(.all)
                        .background(Color.black.opacity(0.06))
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                } else {
                    Image(uiImage: uiImagePhoto)
                        .resizable()
                        .frame(width: photoWidth > photoHeight ? UIScreen.main.bounds.width - 150 : 182,
                               height: photoWidth > photoHeight ? 180 : 220)
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                }
                
                
                //                Image(message.profilPic)
                //                    .resizable()
                //                    .frame(width: 30, height: 30)
                //                    .clipShape(Circle())
            } else {
                Image(message.profilPic)
                    .resizable()
                    .background(Color.vitaProfileBackgroundColor)
                    .frame(width: 52, height: 52)
                    .clipShape(Circle())
                
                if message.photo ==  nil {
                    if message.vitaAnswer != nil {
                        VStack {
                            Text(message.text)
                                .font(.system(.subheadline, weight: .regular))
                                .kerning(-0.4)
                                .foregroundColor(.white)
                                .padding(.bottom, 12)
                            
                            Divider()
                                .padding(.top,1)
                            //                            .fontWidth(22)
                                .background(Color.white)
                            Button {
                                isCompleted.toggle()
                            } label: {
                                Text("Thanks Vita! 👍")
                                    .font(.system(.subheadline, weight: .bold))
                                    .fontDesign(.rounded)
                                    .foregroundColor(.white)
                                    .padding(.top, 16)
                                    .padding(.bottom, 12)
                            }
                        }
                        .padding(.all)
                        .background(Color.chatTopPinkColor)
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                    } else {
                        Text(message.text)
                            .font(.system(.subheadline, weight: .regular))
                            .kerning(-0.4)
                            .foregroundColor(.white)
                            .padding(.all)
                            .background(Color.chatTopPinkColor)
                            .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                    }

                } else {
                    Image(uiImage: UIImage(data:  message.photo!)!)
                        .resizable()
                        .frame(width: photoWidth > photoHeight ?  UIScreen.main.bounds.width - 150 : 182,
                               height: photoWidth > photoHeight ? 150 : 220)
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                }
                
                
                Spacer(minLength: 25)
            }
        }
        .id(message.id)
        .transition(.push(from: .bottom))
    }
}

struct BubbleArrow: Shape {
    var isMyMessage: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: isMyMessage ? [.topLeft, .topRight, .bottomLeft] : [.topRight, .topLeft, .bottomRight], cornerRadii: .init(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}

struct RoundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: .init(width: 35, height: 35))
        return Path(path.cgPath)
    }
}



struct ChatBuble_Previews: PreviewProvider {
    static var previews: some View {
        //        ChatView(chatModel: ChatViewModel(photoData: Data()))
        ChatView(timePhase: .morning)
    }
}
