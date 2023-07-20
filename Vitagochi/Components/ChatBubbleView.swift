//
//  ChatBubbleView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 19/07/23.
//

import SwiftUI

struct ChatBubble: View {
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
                        .kerning(-0.4)
                        .padding(.all)
                        .background(Color.black.opacity(0.06))
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                } else {
                    Image(uiImage: uiImagePhoto)
                        .resizable()
                        .frame(width: photoWidth > photoHeight ? UIScreen.main.bounds.width - 150 : 182,
                               height: photoWidth > photoHeight ? 150 : 220)
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
                }
                
                
                //                Image(message.profilPic)
                //                    .resizable()
                //                    .frame(width: 30, height: 30)
                //                    .clipShape(Circle())
            } else {
                Image(message.profilPic)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                if message.photo ==  nil {
                    Text(message.text)
                        .kerning(-0.4)
                        .foregroundColor(.white)
                        .padding(.all)
                        .background(Color.chatTopPinkColor)
                        .clipShape(BubbleArrow(isMyMessage: message.isMyMessage))
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

